# frozen_string_literal: true

require "test_helper"

class RadioButtonsComponentTest < ViewComponent::TestCase
  def test_renders_radio_buttons_from_collection
    render_inline(RadioButtonsComponent.new(
      form: build_form,
      method: :radio_field,
      collection: simple_collection,
      item_value_method: :value,
      item_label_method: :label
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
      layout: :horizontal
    ))
    assert_selector "div.flex.items-center.gap-cfa-lg"
  end

  def test_legend_renders_above_radios
    render_inline(RadioButtonsComponent.new(
      form: build_form,
      method: :radio_field,
      collection: simple_collection,
      item_value_method: :value,
      item_label_method: :label,
      legend: "Pick one"
    ))
    assert_selector "p", text: "Pick one"
  end

  def test_no_legend_when_omitted
    render_inline(RadioButtonsComponent.new(
      form: build_form,
      method: :radio_field,
      collection: simple_collection,
      item_value_method: :value,
      item_label_method: :label
    ))
    assert_no_selector "p", text: "Pick one"
  end

  def test_invalid_layout_raises
    assert_raises(ArgumentError) do
      RadioButtonsComponent.new(
        form: build_form,
        method: :radio_field,
        collection: simple_collection,
        item_value_method: :value,
        item_label_method: :label,
        layout: :diagonal
      )
    end
  end

  def test_alpine_store_key_defaults_to_method_name
    render_inline(RadioButtonsComponent.new(
      form: build_form,
      method: :radio_field,
      collection: simple_collection,
      item_value_method: :value,
      item_label_method: :label
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
      unique_alpine_store_key: "_unique_key"
    ))
    assert_selector "[x-init*=\"Alpine.store('radio_field_unique_key'\"]"
    assert_selector "input[x-model=\"$store.radio_field_unique_key\"]"
  end

  def test_default_uses_cfa_radio_class
    render_inline(RadioButtonsComponent.new(
      form: build_form,
      method: :radio_field,
      collection: simple_collection,
      item_value_method: :value,
      item_label_method: :label
    ))
    assert_selector "input[type='radio'].cfa-radio", count: 2
    assert_no_selector "input.cfa-radio--small"
  end

  def test_small_variant_applies_modifier_class
    render_inline(RadioButtonsComponent.new(
      form: build_form,
      method: :radio_field,
      collection: simple_collection,
      item_value_method: :value,
      item_label_method: :label,
      small: true
    ))
    assert_selector "input[type='radio'].cfa-radio.cfa-radio--small", count: 2
  end

  def test_error_state_applies_error_modifier
    model = ComponentTestModel.new
    model.errors.add(:radio_field, "is required")
    render_inline(RadioButtonsComponent.new(
      form: build_form(model),
      method: :radio_field,
      collection: simple_collection,
      item_value_method: :value,
      item_label_method: :label
    ))
    assert_selector "input[type='radio'].cfa-radio--error", count: 2
    assert_selector ".form_errors"
  end

  def test_warning_message_renders_warning_state
    render_inline(RadioButtonsComponent.new(
      form: build_form,
      method: :radio_field,
      collection: simple_collection,
      item_value_method: :value,
      item_label_method: :label,
      warning_message: "Heads up!"
    ))
    assert_selector "input[type='radio'].cfa-radio--warning", count: 2
    assert_selector ".form_warning", text: "Heads up!"
  end

  def test_warning_suppressed_when_error_present
    model = ComponentTestModel.new
    model.errors.add(:radio_field, "is required")
    render_inline(RadioButtonsComponent.new(
      form: build_form(model),
      method: :radio_field,
      collection: simple_collection,
      item_value_method: :value,
      item_label_method: :label,
      warning_message: "Heads up!"
    ))
    assert_selector ".form_errors"
    assert_no_selector ".form_warning"
    assert_no_selector "input.cfa-radio--warning"
  end

  def test_unique_id_namespaces_input_ids_label_for_and_store_key
    render_inline(RadioButtonsComponent.new(
      form: build_form,
      method: :radio_field,
      collection: simple_collection,
      item_value_method: :value,
      item_label_method: :label,
      unique_id: "abc"
    ))
    assert_selector "input[type='radio'][id$='_abc']", count: 2
    assert_selector "label[for$='_abc']", count: 2
    assert_selector "[x-init*=\"Alpine.store('radio_field_abc'\"]"
    assert_selector "input[x-model=\"$store.radio_field_abc\"]"
  end
end
