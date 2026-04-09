# frozen_string_literal: true

require "test_helper"

class DropdownComponentTest < ViewComponent::TestCase
  def test_renders_label_and_options
    render_inline(DropdownComponent.new(
      form: build_form,
      method: :dropdown_field,
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
    render_inline(DropdownComponent.new(
      form: build_form,
      method: :dropdown_field,
      label: "Pick one",
      collection: simple_collection,
      item_value_method: :value,
      item_label_method: :label,
      help_text: "Select an option"
    ))
    assert_selector ".help_text", text: "Select an option"
  end

  def test_required_adds_class_to_label
    render_inline(DropdownComponent.new(
      form: build_form,
      method: :dropdown_field,
      label: "Pick one",
      collection: simple_collection,
      item_value_method: :value,
      item_label_method: :label,
      required: true
    ))
    assert_selector "label.required"
  end
end
