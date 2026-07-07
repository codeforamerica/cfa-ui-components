# frozen_string_literal: true

require "test_helper"

# Smoke test: render every Lookbook/ViewComponent preview example to catch
# previews that raise at render time. Inline preview methods are covered by
# their own component tests, but template-backed previews (*.html.erb) are only
# exercised by loading the /inspect page, so broken ones slip through CI.
class PreviewsRenderTest < ViewComponent::TestCase
  ViewComponent::Preview.all.each do |preview_class|
    preview_class.examples.each do |example|
      define_method("test_#{preview_class.name}_#{example}_renders") do
        assert_nothing_raised do
          render_preview(example, from: preview_class)
        end
      end
    end
  end
end
