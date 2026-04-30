# frozen_string_literal: true

require "test_helper"

class RadioButtonsComponentTest < ViewComponent::TestCase
  def test_renders_radio_buttons_from_collection
    render_inline(RadioButtonsComponent.new(
      form: build_form,
      method: :radio_field,
      collection: simple_collection,
      item_value_method: :value,
      item_label_method: :label,
      legend: "Pick one"
    ))
    assert_selector "input[type='radio']", count: 2
    assert_selector "label", text: "Yes"
    assert_selector "label", text: "No"
  end

  def test_horizontal_layout_applies_flex_class
    render_inline(RadioButtonsComponent.new(
      form: build_form,
      method: :radio_field,
      collection: simple_collection,
      item_value_method: :value,
      item_label_method: :label,
      layout: :horizontal,
      legend: "Pick one"
    ))
    assert_selector "div.flex"
  end

  def test_invalid_layout_raises
    assert_raises(ArgumentError) do
      RadioButtonsComponent.new(
        form: build_form,
        method: :radio_field,
        collection: simple_collection,
        item_value_method: :value,
        item_label_method: :label,
        layout: :diagonal,
        legend: "Pick one"
      )
    end
  end

  def test_alpine_store_key_defaults_to_method_name
    render_inline(RadioButtonsComponent.new(
      form: build_form,
      method: :radio_field,
      collection: simple_collection,
      item_value_method: :value,
      item_label_method: :label,
      legend: "Pick one"
    ))
    assert_selector "[x-init*=\"Alpine.store('radio_field'\"]"
    assert_selector "input[x-model=\"$store.radio_field\"]"
  end

  def test_unique_alpine_store_key_appended_to_method_name
    render_inline(RadioButtonsComponent.new(
      form: build_form,
      method: :radio_field,
      collection: simple_collection,
      item_value_method: :value,
      item_label_method: :label,
      unique_alpine_store_key: "_unique_key",
      legend: "Pick one"
    ))
    assert_selector "[x-init*=\"Alpine.store('radio_field_unique_key'\"]"
    assert_selector "input[x-model=\"$store.radio_field_unique_key\"]"
  end

  def test_renders_fieldset
    render_inline(RadioButtonsComponent.new(
      form: build_form,
      method: :radio_field,
      collection: simple_collection,
      item_value_method: :value,
      item_label_method: :label,
      legend: "Do you like pineapple on pizza?"
    ))

    assert_selector "fieldset"
  end

  def test_renders_legend
    render_inline(RadioButtonsComponent.new(
      form: build_form,
      method: :radio_field,
      collection: simple_collection,
      item_value_method: :value,
      item_label_method: :label,
      legend: "Do you like pineapple on pizza?"
    ))

    assert_selector "fieldset > legend", text: "Do you like pineapple on pizza?"
  end
end
