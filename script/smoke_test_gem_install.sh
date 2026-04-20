#!/usr/bin/env bash
# Full end-to-end smoke test: builds the gem, installs it into a fresh
# Rails app (referenced by name, not path/github), runs the install
# generator, builds assets, and renders a component.
#
# Mirrors Mike's manual procedure (PR #71 review). Catches packaging,
# install-generator, and runtime-wiring bugs that the static manifest
# check in verify_gem_package.rb cannot see.

set -euo pipefail

REPO_ROOT="$(cd "$(dirname "$0")/.." && pwd)"
cd "$REPO_ROOT"

echo "==> Building gem"
rm -f cfa_ui_components-*.gem
gem build cfa_ui_components.gemspec
GEM_FILE="$(ls cfa_ui_components-*.gem | head -1)"
GEM_PATH_FILE="$REPO_ROOT/$GEM_FILE"

SCRATCH="$(mktemp -d)"
trap 'rm -rf "$SCRATCH"' EXIT

# If SMOKE_TEST_GEM_HOME is set (in CI, backed by actions/cache), reuse it
# across runs so Rails and its deps don't need to be reinstalled every time.
# Locally it defaults to a scratch dir that gets cleaned up on exit.
GEM_HOME_DIR="${SMOKE_TEST_GEM_HOME:-$SCRATCH/gems}"
mkdir -p "$GEM_HOME_DIR"
export GEM_HOME="$GEM_HOME_DIR"
export GEM_PATH="$GEM_HOME"
export PATH="$GEM_HOME/bin:$PATH"

echo "==> Installing built gem into GEM_HOME ($GEM_HOME)"
gem install "$GEM_PATH_FILE" --no-document --force

echo "==> Ensuring Rails is available in GEM_HOME"
gem install rails --no-document --version '~> 8.0' --conservative
cd "$SCRATCH"
rails new dummy \
  --skip-git \
  --skip-test \
  --skip-system-test \
  --skip-active-storage \
  --skip-action-mailer \
  --skip-action-mailbox \
  --skip-action-cable \
  --skip-action-text \
  --skip-jbuilder \
  -j esbuild \
  -c tailwind
cd dummy

echo "==> Adding cfa_ui_components to Gemfile (by name, no path/github)"
echo 'gem "cfa_ui_components"' >> Gemfile
bundle install --local || bundle install

echo "==> Running install generator"
bin/rails g cfa_ui_components:install

echo "==> Building assets (exercises copy_gem_styles and copy_gem_javascript rake tasks)"
yarn install
yarn build
yarn build:css

echo "==> Verifying copied files landed in expected locations"
test -f app/assets/stylesheets/vendor/cfa_ui_components/cfa_ui_components.tailwind.css
test -f app/javascript/vendor/cfa_ui_components/cfa_ui_components.js
test -f app/javascript/vendor/cfa_ui_components/combobox.ts

echo "==> Rendering a component via rails runner"
bin/rails runner '
  html = ApplicationController.render(
    LinkComponent.new(label: "hi", url: "/x")
  )
  raise "empty render" if html.strip.empty?
  raise "missing label" unless html.include?("hi")
  puts "rendered: #{html.strip}"
'

echo "==> Smoke test passed."
