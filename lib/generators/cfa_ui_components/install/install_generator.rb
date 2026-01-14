require "rails/generators"

module CfaUiComponents
  class InstallGenerator < Rails::Generators::Base
    # Heavily inspired by https://github.com/getrailsui/railsui/blob/main/lib/generators/railsui/install/install_generator.rb
    def check_dependencies
      unless using_tool?(:yarn) && using_esbuild_and_tailwind?
        say "=" * 70, :red
        say "❌ CfA UI Components requires esbuild, tailwind, and yarn", :red
        say "=" * 70, :red
        say "These can be added with the following commands:", :cyan
        say "  bundle add jsbundling-rails", :cyan
        say "  rails javascript:install:esbuild", :cyan
        say "  bundle add cssbundling-rails", :cyan
        say "  rails css:install:tailwind", :cyan
        say "You may have to do some additional work if you are switching over from importmaps or another css tool", :magenta
        say "Alternatively, if this is a brand new rails app, you can regenerate it with the correct tooling:", :cyan
        say "  rails new <app_name> <other flags> -j esbuild -c tailwind"
        exit(1)
      end
    end

    def add_css_import
      application_css_path = "app/assets/stylesheets/application.tailwind.css"
      import_components_line = "@import \"./vendor/cfa_ui_components.tailwind.css\";\n"
      import_tailwind_line = "@import \"tailwindcss\";"
      insert_into_file application_css_path, import_components_line, before: import_tailwind_line
    end

    def add_js_import
      application_js_path = "app/javascript/application.js"
      import_components_line = "import \"./vendor/cfa_ui_components\"\n"
      append_to_file application_js_path, import_components_line
    end

    def add_copy_steps_to_build_scripts
      package_json_file = "package.json"

      copy_js = "bundle exec rake cfa_ui_components:copy_gem_javascript && "
      build_js = "esbuild app/javascript/*.*"
      inject_into_file package_json_file, copy_js, before: build_js

      copy_css = "bundle exec rake cfa_ui_components:copy_gem_styles && "
      build_css = "npx @tailwindcss/cli"
      inject_into_file package_json_file, copy_css, before: build_css
    end

    def add_js_dependencies
      run "yarn add alpinejs @alpinejs/mask"
    end

    def add_components_to_gitignore
      gitignore_path = ".gitignore"
      component_filename_lines = "cfa_ui_components.tailwind.css\ncfa_ui_components.js\n"
      append_to_file gitignore_path, component_filename_lines
    end

    private

    # Taken & modified from https://github.com/getrailsui/railsui/blob/main/lib/railsui/theme_setup.rb
    def gem_installed?(gem_name)
      Gem::Specification.find_by_name(gem_name)
      true
    rescue Gem::LoadError
      false
    end

    def using_esbuild_and_tailwind?
      package_json = Rails.root.join("package.json")
      if File.exist?(package_json)
        content = File.read(package_json)
        data = JSON.parse(content) rescue {}
        build_script = data.dig("scripts", "build").to_s
        css_build_script = data.dig("scripts", "build:css").to_s

        build_script.include?("esbuild") && css_build_script.include?("tailwind")
      end
    end

    # Taken from https://github.com/rails/cssbundling-rails/blob/main/lib/tasks/cssbundling/build.rake
    LOCK_FILES = {
      bun: %w[bun.lockb bun.lock],
      yarn: %w[yarn.lock],
      pnpm: %w[pnpm-lock.yaml],
      npm: %w[package-lock.json]
    }

    def tool_exists?(tool)
      system "command -v #{tool} > /dev/null"
    end

    def using_tool?(tool)
      tool_exists?(tool) && LOCK_FILES[tool].any? { |file| File.exist?(file) }
    end
  end
end
