namespace :cfa_ui_components do
  desc "Copy CfA UI Components stylesheet to application. Ensure that copied files are included in .gitignore."
  task copy_gem_styles: :environment do
    gem_spec = Gem.loaded_specs["cfa_ui_components"]
    if gem_spec
      # Copy stylesheet
      # Prepend a @source directive that instructs Tailwind not to purge utility classes used in the components.
      # You must also use cssbundling to install tailwind, and add `@import "./vendor/cfa_ui_components.tailwind.css";`
      # to the top of your application.tailwind.css
      css_source = File.join(gem_spec.full_gem_path, "app/assets/stylesheets/cfa_ui_components.tailwind.css")
      css_dest = Rails.root.join("app/assets/stylesheets/vendor/cfa_ui_components.tailwind.css")
      FileUtils.mkdir_p(File.dirname(css_dest))
      Tempfile.open do |temp_file|
        source_line = "@source \"#{gem_spec.full_gem_path}\";\n\n"
        temp_file.write(source_line)
        temp_file.write(File.read(css_source))
        FileUtils.mv(temp_file.path, css_dest)
      end
    end
  end

  desc "Copy CfA UI Components javascript to application. Ensure that copied files are included in .gitignore."
  task copy_gem_javascript: :environment do
    gem_spec = Gem.loaded_specs["cfa_ui_components"]
    if gem_spec
      # Copy javascript.
      # You must also run `yarn add alpinejs @alpinejs/mask`, and add `import vendor/cfa_ui_components` to application.js
      js_source = File.join(gem_spec.full_gem_path, "app/javascript/cfa_ui_components.js")
      js_dest = Rails.root.join("app/javascript/vendor/cfa_ui_components.js")
      FileUtils.mkdir_p(File.dirname(js_dest))
      FileUtils.cp(js_source, js_dest)
    end
  end
end
