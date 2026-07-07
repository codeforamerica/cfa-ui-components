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
    assert_selector "div.flex.items-center.gap-cfa-lg"
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

  def test_scope_appended_to_method_name
    render_inline(RadioButtonsComponent.new(
      form: build_form,
      method: :radio_field,
      collection: simple_collection,
      item_value_method: :value,
      item_label_method: :label,
      scope: "unique_key",
      legend: "Pick one"
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
      item_label_method: :label,
      legend: "Pick one"
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
      small: true,
      legend: "Pick one"
    ))
    assert_selector "input[type='radio'].cfa-radio.cfa-radio--small", count: 2
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

    assert_selector "fieldset > legend.sr-only", text: "Do you like pineapple on pizza?"
  end

  def test_aria_labelledby_sets_fieldset_attribute_without_legend
    render_inline(RadioButtonsComponent.new(
      form: build_form,
      method: :radio_field,
      collection: simple_collection,
      item_value_method: :value,
      item_label_method: :label,
      aria_labelledby: "external-heading"
    ))

    assert_selector "fieldset[aria-labelledby='external-heading']"
    assert_no_selector "legend"
  end

  def test_raises_when_neither_legend_nor_aria_labelledby_provided
    assert_raises(ArgumentError) do
      RadioButtonsComponent.new(
        form: build_form,
        method: :radio_field,
        collection: simple_collection,
        item_value_method: :value,
        item_label_method: :label
      )
    end
  end

  def test_error_state_applies_error_modifier
    model = ComponentTestModel.new
    model.errors.add(:radio_field, "is required")
    render_inline(RadioButtonsComponent.new(
      form: build_form(model),
      method: :radio_field,
      collection: simple_collection,
      item_value_method: :value,
      item_label_method: :label,
      legend: "Pick one"
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
      warning_message: "Heads up!",
      legend: "Pick one"
    ))
    assert_selector "input[type='radio'].cfa-radio--warning", count: 2
    assert_selector ".form_warning", text: "Heads up!"
    assert_selector ".form_warning .cfa-icon.text-warning"
  end

  def test_warning_and_error_render_together
    model = ComponentTestModel.new
    model.errors.add(:radio_field, "is required")
    render_inline(RadioButtonsComponent.new(
      form: build_form(model),
      method: :radio_field,
      collection: simple_collection,
      item_value_method: :value,
      item_label_method: :label,
      warning_message: "Heads up!",
      legend: "Pick one"
    ))
    assert_selector ".form_errors"
    assert_selector ".form_warning", text: "Heads up!"
    assert_no_selector "input.cfa-radio--warning"
  end

  def test_scope_namespaces_input_ids_label_for_and_store_key
    render_inline(RadioButtonsComponent.new(
      form: build_form,
      method: :radio_field,
      collection: simple_collection,
      item_value_method: :value,
      item_label_method: :label,
      scope: "abc",
      legend: "Pick one"
    ))
    assert_selector "input[type='radio'][id$='_abc']", count: 2
    assert_selector "label[for$='_abc']", count: 2
    assert_selector "[x-init*=\"Alpine.store('radio_field_abc'\"]"
    assert_selector "input[x-model=\"$store.radio_field_abc\"]"
  end

  def test_sets_aria_posinset_and_setsize_for_screen_readers
    render_inline(RadioButtonsComponent.new(
      form: build_form,
      method: :radio_field,
      collection: simple_collection,
      item_value_method: :value,
      item_label_method: :label,
      legend: "Pick one"
    ))
    assert_selector "input[type='radio'][aria-setsize='2']", count: 2
    assert_selector "input[type='radio'][aria-posinset='1']", count: 1
    assert_selector "input[type='radio'][aria-posinset='2']", count: 1
  end

  def test_css_class_is_appended_to_root
    render_inline(RadioButtonsComponent.new(
      form: build_form,
      method: :radio_field,
      collection: simple_collection,
      item_value_method: :value,
      item_label_method: :label,
      legend: "Radio group",
      css_class: "mt-cfa-lg"
    ))
    assert_selector "fieldset.mt-cfa-lg"
  end
end
