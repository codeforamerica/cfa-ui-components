require "test_helper"
require "rake"

class CopyGemStylesTest < ActiveSupport::TestCase
  setup do
    Rails.application.load_tasks unless Rake::Task.task_defined?("cfa_ui_components:copy_gem_styles")
    @task = Rake::Task["cfa_ui_components:copy_gem_styles"]
    @task.reenable
    @app_root = Pathname.new(Dir.mktmpdir)
    @original_gem_spec = Gem.loaded_specs["cfa_ui_components"]
    Gem.loaded_specs["cfa_ui_components"] = Struct.new(:full_gem_path).new(Rails.root.to_s)
  end

  teardown do
    Gem.loaded_specs["cfa_ui_components"] = @original_gem_spec
    FileUtils.rm_rf(@app_root)
  end

  test "writes the full umbrella when the temp dir is on another filesystem" do
    gem_path = Rails.root.to_s
    with_rails_root(@app_root) do
      with_cross_device_mv { @task.invoke }
    end

    source_css = File.read(File.join(gem_path, "app/assets/stylesheets/cfa_ui_components/cfa_ui_components.tailwind.css"))
    copied_css = File.read(@app_root.join("app/assets/stylesheets/vendor/cfa_ui_components/cfa_ui_components.tailwind.css"))

    assert_equal "@source \"#{gem_path}\";\n\n#{source_css}", copied_css
  end

  private

  def with_rails_root(root)
    original_root = Rails.method(:root)
    Rails.define_singleton_method(:root) { root }
    yield
  ensure
    Rails.define_singleton_method(:root, original_root)
  end

  def with_cross_device_mv
    original_mv = FileUtils.method(:mv)
    FileUtils.define_singleton_method(:mv) do |src, dest, **options|
      FileUtils.cp(src, dest, **options)
      FileUtils.rm(src)
    end
    yield
  ensure
    FileUtils.define_singleton_method(:mv, original_mv)
  end
end
