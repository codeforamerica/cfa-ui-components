# frozen_string_literal: true

require "test_helper"

class ComboboxComponentTest < ViewComponent::TestCase
  def test_renders_label_and_select
    render_inline(ComboboxComponent.new(
      form: build_form,
      method: :combobox_field,
      label: "Choose fruit",
      collection: simple_collection,
      item_value_method: :value,
      item_label_method: :label
    ))
    assert_selector "label", text: "Choose fruit"
    assert_selector "select"
    assert_selector "option", text: "Yes"
    assert_selector "option", text: "No"
  end

  def test_renders_help_text
    render_inline(ComboboxComponent.new(
      form: build_form,
      method: :combobox_field,
      label: "Choose fruit",
      collection: simple_collection,
      item_value_method: :value,
      item_label_method: :label,
      help_text: "Pick one"
    ))
    assert_selector ".help_text", text: "Pick one"
  end

  def test_required_sets_aria_required_and_omits_optional_marker
    render_inline(ComboboxComponent.new(
      form: build_form,
      method: :combobox_field,
      label: "Choose fruit",
      collection: simple_collection,
      item_value_method: :value,
      item_label_method: :label,
      required: true
    ))
    assert_selector "label", text: "Choose fruit"
    assert_no_text "(optional)"
    assert_selector "select[aria-required='true']"
  end

  def test_optional_appends_optional_marker_and_omits_aria_required
    render_inline(ComboboxComponent.new(
      form: build_form,
      method: :combobox_field,
      label: "Choose fruit",
      collection: simple_collection,
      item_value_method: :value,
      item_label_method: :label
    ))
    assert_selector "label", text: "Choose fruit (optional)"
    assert_no_selector "select[aria-required]"
  end

  def test_item_disabled_method_marks_options_disabled
    collection = [
      OpenStruct.new(value: "yes", label: "Yes", unavailable: false),
      OpenStruct.new(value: "no", label: "No", unavailable: true)
    ]
    render_inline(ComboboxComponent.new(
      form: build_form,
      method: :combobox_field,
      label: "Choose fruit",
      collection:,
      item_value_method: :value,
      item_label_method: :label,
      item_disabled_method: :unavailable
    ))
    assert_selector "option[value='no'][disabled]"
    assert_no_selector "option[value='yes'][disabled]"
  end
end
