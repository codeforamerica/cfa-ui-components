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

  def test_required_by_default_sets_aria_required_and_omits_optional_marker
    render_inline(InputComponent.new(form: build_form, method: :text_field, label: "Full name"))
    assert_selector "label", text: "Full name"
    assert_no_text "(optional)"
    assert_selector "input[type='text'][aria-required='true']"
  end

  def test_optional_appends_optional_marker_and_omits_aria_required
    render_inline(InputComponent.new(form: build_form, method: :text_field, label: "Full name", optional: true))
    assert_selector "label", text: "Full name (optional)"
    assert_no_selector "input[aria-required]"
  end

  def test_css_class_is_appended_to_root
    render_inline(InputComponent.new(form: build_form, method: :text_field, label: "Full name", css_class: "mt-cfa-lg"))
    assert_selector "div.cfa-stack-sm.mt-cfa-lg"
  end

  def test_input_attrs_are_forwarded_to_the_field
    render_inline(InputComponent.new(form: build_form, method: :text_field, label: "Full name", input_attrs: {inputmode: "tel", autocomplete: "tel"}))
    assert_selector "input[inputmode='tel'][autocomplete='tel']"
  end
end
