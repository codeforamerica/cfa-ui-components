require "rails/engine"
require "view_component"
require "fileutils"

module CfaUiComponents
  class Engine < ::Rails::Engine
    isolate_namespace CfaUiComponents

    # Use a span instead of Rails' default div to avoid breaking inline layouts
    initializer "field_with_errors span wrapper" do |app|
      puts "using span for .field_with_errors wrapper (in engine)" unless Rails.env.test?
      ActionView::Base.field_error_proc = proc do |html_tag, _instance|
        %(<span class="field_with_errors">#{html_tag}</span>).html_safe
      end
    end

    initializer "tell zeitwerk to ignore generators" do |app|
      # Copied from https://github.com/rails/rails/issues/38671#issuecomment-2460201789
      puts "Telling Zeitwerk to ignore our generators, as they don't follow the conventional mapping from path to fully-qualified class name (in engine)" unless Rails.env.test?
      Rails.autoloaders.main.ignore(File.expand_path("../generators", __dir__))
    end
  end
end
