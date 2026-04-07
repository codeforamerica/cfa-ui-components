# frozen_string_literal: true

require "test_helper"

class CheckboxesComponentTest < ViewComponent::TestCase
  def test_renders_checkboxes_from_collection
    render_inline(CheckboxesComponent.new(
      form: build_form,
      method: :checkboxes_field,
      collection: simple_collection,
      item_value_method: :value,
      item_label_method: :label
    ))
    assert_selector "input[type='checkbox']", count: 2
    assert_selector "label", text: "Yes"
    assert_selector "label", text: "No"
  end

  def test_renders_hidden_field
    render_inline(CheckboxesComponent.new(
      form: build_form,
      method: :checkboxes_field,
      collection: simple_collection,
      item_value_method: :value,
      item_label_method: :label
    ))
    assert_selector "input[type='hidden'][value='']", visible: :all
  end
end
