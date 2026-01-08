# frozen_string_literal: true

require_relative "lib/cfa_ui_components/version"

Gem::Specification.new do |spec|
  spec.name = "cfa_ui_components"
  spec.version = CfaUiComponents::Version
  spec.authors = [ "Mike Rotondo" ]
  spec.email = [ "mrotondo@codeforamerica.org" ]

  spec.summary = "For when you want to have your UI be components"
  spec.homepage = "https://github.com/codeforamerica/cfa-ui-components/blob/main/README.md"
  spec.required_ruby_version = ">= 3.1.0"
  spec.licenses = "Nonstandard"  # TODO: Change this when we go public

  spec.files = Dir[
    "lib/cfa_ui_components.rb",
    "lib/cfa_ui_components/**/*",
    "app/components/**/*",
    "app/assets/stylesheets/cfa_ui_components.tailwind.css",
    "app/javascript/cfa_ui_components.js",
    "lib/tasks/cfa_ui_components.rake",
    "app/assets/images/icons/*"
  ]
  spec.require_paths = [ "lib" ]

  spec.add_dependency "rails", "~> 8.0"
  spec.add_dependency "cssbundling-rails", "~> 1.0"
  spec.add_dependency "view_component", "~> 4.0"
end
