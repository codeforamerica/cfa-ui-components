# frozen_string_literal: true

require "test_helper"

class InputComponentTest < ViewComponent::TestCase
  def test_renders_label_and_input
    render_inline(InputComponent.new(form: build_form, method: :text_field, label: "Full name"))
    assert_selector "label", text: "Full name"
    assert_selector "input[type='text']"
  end

  def test_renders_help_text
    render_inline(InputComponent.new(form: build_form, method: :text_field, label: "Full name", help_text: "Enter your full name"))
    assert_selector ".help_text", text: "Enter your full name"
  end

  def test_required_adds_class_to_label
    render_inline(InputComponent.new(form: build_form, method: :text_field, label: "Full name", required: true))
    assert_selector "label.required"
  end
end
