require_relative "boot"

require "rails"

# Stripped down rails, since we don't need much
%w[
  action_controller/railtie
  action_view/railtie
  action_cable/engine
  rails/test_unit/railtie
].each do |railtie|
  begin # rubocop:disable Style/RedundantBegin
    require railtie
  rescue LoadError
  end
end


# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module CfaUiComponents
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 8.0

    # Please, add to the `ignore` list any other `lib` subdirectories that do
    # not contain `.rb` files, or that should not be reloaded or eager loaded.
    # Common ones are `templates`, `generators`, or `middleware`, for example.
    config.autoload_lib(ignore: %w[assets tasks])

    # Configuration for the application, engines, and railties goes here.
    #
    # These settings can be overridden in specific environments using the files
    # in config/environments, which are processed later.
    #
    # config.time_zone = "Central Time (US & Canada)"
    # config.eager_load_paths << Rails.root.join("extras")
    config.view_component.previews.paths = [ "#{Rails.root}/test/components/previews" ]

    config.view_component.previews.default_layout = "component_preview"
    config.lookbook.preview_controller = "PreviewController"
    config.lookbook.preview_display_options = {
      lang: [
        [ "English", "en" ],
        [ "Spanish", "es" ]
      ]
    }
  end
end
