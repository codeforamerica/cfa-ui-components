# frozen_string_literal: true

require "test_helper"

class SelectComponentTest < ViewComponent::TestCase
  def test_renders_label_and_options
    render_inline(SelectComponent.new(
      form: build_form,
      method: :select_field,
      label: "Pick one",
      collection: simple_collection,
      item_value_method: :value,
      item_label_method: :label
    ))
    assert_selector "label", text: "Pick one"
    assert_selector "option", text: "Yes"
    assert_selector "option", text: "No"
  end

  def test_renders_help_text
    render_inline(SelectComponent.new(
      form: build_form,
      method: :select_field,
      label: "Pick one",
      collection: simple_collection,
      item_value_method: :value,
      item_label_method: :label,
      help_text: "Select an option"
    ))
    assert_selector ".help_text", text: "Select an option"
  end

  def test_required_by_default_sets_aria_required_and_omits_optional_marker
    render_inline(SelectComponent.new(
      form: build_form,
      method: :select_field,
      label: "Pick one",
      collection: simple_collection,
      item_value_method: :value,
      item_label_method: :label
    ))
    assert_selector "label", text: "Pick one"
    assert_no_text "(optional)"
    assert_selector "select[aria-required='true']"
  end

  def test_optional_appends_optional_marker_and_omits_aria_required
    render_inline(SelectComponent.new(
      form: build_form,
      method: :select_field,
      label: "Pick one",
      collection: simple_collection,
      item_value_method: :value,
      item_label_method: :label,
      optional: true
    ))
    assert_selector "label", text: "Pick one (optional)"
    assert_no_selector "select[aria-required]"
  end

  def test_css_class_is_appended_to_root
    render_inline(SelectComponent.new(
      form: build_form,
      method: :select_field,
      label: "Pick one",
      collection: simple_collection,
      item_value_method: :value,
      item_label_method: :label,
      css_class: "mt-cfa-lg"
    ))
    assert_selector "div.cfa-stack-sm.mt-cfa-lg"
  end

  def test_input_attrs_are_forwarded_to_the_field
    render_inline(SelectComponent.new(
      form: build_form,
      method: :select_field,
      label: "Pick one",
      collection: simple_collection,
      item_value_method: :value,
      item_label_method: :label,
      input_attrs: {autocomplete: "country"}
    ))
    assert_selector "select[autocomplete='country']"
  end
end
