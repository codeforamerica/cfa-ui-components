namespace :cfa_ui_components do
  desc "Copy CfA UI Components stylesheet to application. Ensure that copied files are included in .gitignore."
  task copy_gem_styles: :environment do
    gem_spec = Gem.loaded_specs["cfa_ui_components"]
    if gem_spec
      css_source = File.join(gem_spec.full_gem_path, "app/assets/stylesheets/cfa_ui_components.tailwind.css")
      css_dest = Rails.root.join("app/assets/stylesheets/vendor/cfa_ui_components.tailwind.css")
      FileUtils.mkdir_p(File.dirname(css_dest))

      # Prepend a @source directive that instructs Tailwind to scan the gem source while deciding which utility classes not to purge.
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
      js_source = File.join(gem_spec.full_gem_path, "app/javascript/cfa_ui_components.js")
      js_dest = Rails.root.join("app/javascript/vendor/cfa_ui_components.js")
      FileUtils.mkdir_p(File.dirname(js_dest))

      FileUtils.cp(js_source, js_dest)
    end
  end
end
