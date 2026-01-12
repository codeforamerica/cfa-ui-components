require "rails/engine"
require "view_component"
require "fileutils"

module CfaUiComponents
  class Engine < ::Rails::Engine
    isolate_namespace CfaUiComponents

    initializer "disable .field_with_errors" do |app|
      puts "disabling .field_with_errors wrapper (in engine)"
      ActionView::Base.field_error_proc = proc do |html_tag, instance|
        html_tag.html_safe
      end
    end

    initializer "tell zeitwerk to ignore generators" do |app|
      # Copied from https://github.com/rails/rails/issues/38671#issuecomment-2460201789
      puts "Telling Zeitwerk to ignore our generators, as they don't follow the conventional mapping from path to fully-qualified class name (in engine)"
      Rails.autoloaders.main.ignore(File.expand_path("../generators", __dir__))
    end
  end
end
