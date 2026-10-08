require "test_helper"
require "capybara/cuprite"

# `bin/rails test` does not run `test:prepare` (only `rake test` does), so the
# jsbundling-rails / cssbundling-rails build hooks never fire. Build the
# preview app's bundles here so `javascript_include_tag "application"` resolves
# and so edits to JS/CSS sources are reflected in system tests.
system("yarn build && yarn build:css", exception: true, chdir: Rails.root.to_s)

class ApplicationSystemTestCase < ActionDispatch::SystemTestCase
  driven_by :rack_test
end

class JavaScriptSystemTestCase < ApplicationSystemTestCase
  # Rails registers its own :cuprite driver from these arguments, replacing
  # any Capybara.register_driver(:cuprite), so options must be passed here.
  driven_by :cuprite, screen_size: [1400, 1400], options: {headless: true, process_timeout: 30, timeout: 30}
end
