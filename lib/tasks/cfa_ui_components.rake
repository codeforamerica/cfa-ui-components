namespace :cfa_ui_components do
  desc "Copy CfA UI Components stylesheet to application. Ensure that copied files are included in .gitignore."
  task copy_gem_styles: :environment do
    gem_spec = Gem.loaded_specs["cfa_ui_components"]
    if gem_spec
      stylesheets_source_dir = File.join(gem_spec.full_gem_path, "app/assets/stylesheets/cfa_ui_components")
      stylesheets_dest_dir = Rails.root.join("app/assets/stylesheets/vendor/cfa_ui_components")
      FileUtils.mkdir_p(stylesheets_dest_dir)

      # Copy partial subdirectories (base/, components/, utilities/) that
      # the entry CSS @imports. Without these, Tailwind can't resolve them.
      Dir.glob(File.join(stylesheets_source_dir, "*")).each do |entry|
        FileUtils.cp_r(entry, stylesheets_dest_dir) if File.directory?(entry)
      end

      # Prepend a @source directive that instructs Tailwind to scan the gem source while deciding which utility classes not to purge.
      css_source = File.join(stylesheets_source_dir, "cfa_ui_components.tailwind.css")
      css_dest = stylesheets_dest_dir.join("cfa_ui_components.tailwind.css")
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
      js_source_dir = File.join(gem_spec.full_gem_path, "app/javascript/cfa_ui_components")
      js_dest_dir = Rails.root.join("app/javascript/vendor/cfa_ui_components")
      FileUtils.mkdir_p(js_dest_dir)
      Dir.glob(File.join(js_source_dir, "*")).each do |entry|
        FileUtils.cp_r(entry, js_dest_dir)
      end
    end
  end
end
