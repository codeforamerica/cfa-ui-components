# frozen_string_literal: true

require_relative "lib/cfa_ui_components/version"

Gem::Specification.new do |spec|
  spec.name = "cfa_ui_components"
  spec.version = CfaUiComponents::Version
  spec.authors = ["Mike Rotondo"]
  spec.email = ["mrotondo@codeforamerica.org"]

  spec.summary = "For when you want to have your UI be components"
  spec.homepage = "https://github.com/codeforamerica/cfa-ui-components/blob/main/README.md"
  spec.licenses = "Nonstandard"  # TODO: Change this when we go public

  ruby_version_file = File.expand_path(".ruby-version", __dir__)
  if File.exist?(ruby_version_file)
    version = File.read(ruby_version_file).strip
    spec.required_ruby_version = ">= #{version}"
  end

  spec.files = Dir[
    "lib/cfa_ui_components.rb",
    "lib/cfa_ui_components/**/*",
    "app/components/**/*",
    "app/form_builders/**/*",
    "app/assets/stylesheets/cfa_ui_components/**/*",
    "app/assets/fonts/cfa_ui_components/**/*",
    "app/javascript/cfa_ui_components/**/*",
    "app/assets/images/uswds-sprite.svg",
    "app/assets/images/icons/*",
    "lib/generators/**/*",
    "lib/tasks/cfa_ui_components.rake"
  ]
  spec.require_paths = ["lib"]

  spec.add_dependency "rails", "~> 8.0"
  spec.add_dependency "cssbundling-rails", "~> 1.0"
  spec.add_dependency "view_component", "~> 4.0"
end
