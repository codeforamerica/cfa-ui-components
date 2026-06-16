# frozen_string_literal: true

require "test_helper"

class FormWarningComponentTest < ViewComponent::TestCase
  def test_renders_warning_message
    render_inline(FormWarningComponent.new(warning_message: "Heads up"))
    assert_selector "p.form_warning", text: "Heads up"
  end

  def test_css_class_is_appended_without_dropping_base_classes
    render_inline(FormWarningComponent.new(warning_message: "Heads up", css_class: "mt-cfa-sm"))
    assert_selector "p.form_warning.mt-cfa-sm.text-text-body-secondary"
  end
end
