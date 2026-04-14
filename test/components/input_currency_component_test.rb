# frozen_string_literal: true

require "test_helper"

class InputCurrencyComponentTest < ViewComponent::TestCase
  def test_renders_label_and_input
    render_inline(InputCurrencyComponent.new(form: build_form, method: :text_field, label: "Number"))
    assert_selector "label", text: "Number"
    assert_selector "input[type='text']"
  end

  def test_renders_help_text
    render_inline(InputCurrencyComponent.new(form: build_form, method: :text_field, label: "Number", help_text: "Enter your Number"))
    assert_selector ".help_text", text: "Enter your Number"
  end

  def test_required_adds_class_to_label
    render_inline(InputCurrencyComponent.new(form: build_form, method: :text_field, label: "Number", required: true))
    assert_selector "label.required"
  end
end
