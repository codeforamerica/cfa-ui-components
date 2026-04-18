#!/usr/bin/env ruby
# frozen_string_literal: true

# Builds the gem, unpacks it, and verifies that every source file we expect
# to ship is actually present in the built package. Catches gemspec globs
# that silently miss files.

require "fileutils"
require "tmpdir"
require "shellwords"

REPO_ROOT = File.expand_path("..", __dir__)

# Globs whose matches in the repo must all appear in the built gem.
# Keep in sync with cfa_ui_components.gemspec's spec.files.
EXPECTED_GLOBS = [
  "lib/cfa_ui_components.rb",
  "lib/cfa_ui_components/**/*.rb",
  "lib/generators/**/*",
  "lib/tasks/cfa_ui_components.rake",
  "app/components/**/*",
  "app/assets/stylesheets/**/*.css",
  "app/assets/images/icons/*",
  "app/javascript/cfa_ui_components.js",
  "app/javascript/combobox.ts"
].freeze

def sh!(cmd, chdir: REPO_ROOT)
  puts "$ #{cmd}"
  raise "command failed: #{cmd}" unless system(cmd, chdir: chdir)
end

Dir.chdir(REPO_ROOT) do
  Dir["cfa_ui_components-*.gem"].each { |f| File.delete(f) }
  sh! "gem build cfa_ui_components.gemspec"
end

gem_file = Dir[File.join(REPO_ROOT, "cfa_ui_components-*.gem")].first
raise "no .gem produced" unless gem_file

Dir.mktmpdir do |dir|
  sh! "gem unpack #{Shellwords.escape(gem_file)} --target #{Shellwords.escape(dir)}"
  unpacked = Dir[File.join(dir, "cfa_ui_components-*")].first
  raise "unpack failed" unless unpacked

  expected_files = EXPECTED_GLOBS.flat_map { |g| Dir[File.join(REPO_ROOT, g)] }
                                 .select { |p| File.file?(p) }
                                 .map { |p| p.sub("#{REPO_ROOT}/", "") }
                                 .sort
                                 .uniq

  missing = expected_files.reject { |rel| File.file?(File.join(unpacked, rel)) }

  if missing.empty?
    puts "OK — all #{expected_files.size} expected files present in built gem."
  else
    warn "MISSING from built gem (#{missing.size} files):"
    missing.each { |f| warn "  - #{f}" }
    exit 1
  end
end
