# frozen_string_literal: true

require "test_helper"

class CheckboxesComponentTest < ViewComponent::TestCase
  def test_renders_checkboxes_from_collection
    render_inline(CheckboxesComponent.new(
      form: build_form,
      method: :checkboxes_field,
      collection: simple_collection,
      item_value_method: :value,
      item_label_method: :label,
      legend: "Pick some"
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
      item_label_method: :label,
      legend: "Pick some"
    ))
    assert_selector "input[type='hidden'][value='']", visible: :all
  end

  def test_small_variant_uses_smaller_box
    render_inline(CheckboxesComponent.new(
      form: build_form,
      method: :checkboxes_field,
      collection: simple_collection,
      item_value_method: :value,
      item_label_method: :label,
      small: true,
      legend: "Pick some"
    ))
    assert_selector "input[type='checkbox'].h-4.w-4", count: 2
    assert_no_selector "input[type='checkbox'].h-6.w-6"
  end

  def test_default_uses_regular_box
    render_inline(CheckboxesComponent.new(
      form: build_form,
      method: :checkboxes_field,
      collection: simple_collection,
      item_value_method: :value,
      item_label_method: :label,
      legend: "Pick some"
    ))
    assert_selector "input[type='checkbox'].h-6.w-6", count: 2
  end

  def test_renders_fieldset
    render_inline(CheckboxesComponent.new(
      form: build_form,
      method: :checkboxes_field,
      collection: simple_collection,
      item_value_method: :value,
      item_label_method: :label,
      legend: "What are your favorite fruits?"
    ))

    assert_selector "fieldset"
  end

  def test_renders_legend
    render_inline(CheckboxesComponent.new(
      form: build_form,
      method: :checkboxes_field,
      collection: simple_collection,
      item_value_method: :value,
      item_label_method: :label,
      legend: "What are your favorite fruits?"
    ))

    assert_selector "fieldset > legend.sr-only", text: "What are your favorite fruits?"
  end

  def test_aria_labelledby_sets_fieldset_attribute_without_legend
    render_inline(CheckboxesComponent.new(
      form: build_form,
      method: :checkboxes_field,
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
      CheckboxesComponent.new(
        form: build_form,
        method: :checkboxes_field,
        collection: simple_collection,
        item_value_method: :value,
        item_label_method: :label
      )
    end
  end

  def test_warning_message_renders_warning_state
    render_inline(CheckboxesComponent.new(
      form: build_form,
      method: :checkboxes_field,
      collection: simple_collection,
      item_value_method: :value,
      item_label_method: :label,
      warning_message: "Heads up!",
      legend: "Pick some"
    ))
    assert_selector ".form_warning", text: "Heads up!"
    assert_selector "input[type='checkbox'].cfa-checkbox--warning", count: 2
    assert_selector ".form_warning .cfa-icon.text-warning"
  end

  def test_warning_and_error_render_together
    model = ComponentTestModel.new
    model.errors.add(:checkboxes_field, "is required")
    render_inline(CheckboxesComponent.new(
      form: build_form(model),
      method: :checkboxes_field,
      collection: simple_collection,
      item_value_method: :value,
      item_label_method: :label,
      warning_message: "Heads up!",
      legend: "Pick some"
    ))
    assert_selector ".form_errors"
    assert_selector ".form_warning", text: "Heads up!"
  end

  def test_item_states_indeterminate_sets_alpine_init_on_matching_items
    render_inline(CheckboxesComponent.new(
      form: build_form,
      method: :checkboxes_field,
      collection: simple_collection,
      item_value_method: :value,
      item_label_method: :label,
      item_states: {"yes" => :indeterminate},
      legend: "Pick some"
    ))
    assert_selector "input[type='checkbox'][value='yes'][x-init='$nextTick(() => $el.indeterminate = true)']"
    assert_no_selector "input[type='checkbox'][value='no'][x-init]"
  end

  def test_item_states_disabled_disables_input_and_styles_label
    render_inline(CheckboxesComponent.new(
      form: build_form,
      method: :checkboxes_field,
      collection: simple_collection,
      item_value_method: :value,
      item_label_method: :label,
      item_states: {"yes" => :disabled},
      legend: "Pick some"
    ))
    assert_selector "input[type='checkbox'][value='yes'][disabled]"
    assert_no_selector "input[type='checkbox'][value='no'][disabled]"
    assert_selector "label.text-text-disabled", text: "Yes"
  end

  def test_item_states_mixed_per_item
    render_inline(CheckboxesComponent.new(
      form: build_form,
      method: :checkboxes_field,
      collection: simple_collection,
      item_value_method: :value,
      item_label_method: :label,
      item_states: {"yes" => :disabled, "no" => :indeterminate},
      legend: "Pick some"
    ))
    assert_selector "input[type='checkbox'][value='yes'][disabled]"
    assert_selector "input[type='checkbox'][value='no'][x-init='$nextTick(() => $el.indeterminate = true)']"
  end

  def test_item_states_rejects_unknown_state
    assert_raises(ArgumentError) do
      CheckboxesComponent.new(
        form: build_form,
        method: :checkboxes_field,
        collection: simple_collection,
        item_value_method: :value,
        item_label_method: :label,
        item_states: {"yes" => :bogus},
        legend: "Pick some"
      )
    end
  end

  def test_scope_namespaces_input_ids_and_label_for
    render_inline(CheckboxesComponent.new(
      form: build_form,
      method: :checkboxes_field,
      collection: simple_collection,
      item_value_method: :value,
      item_label_method: :label,
      scope: "abc",
      legend: "Pick some"
    ))
    assert_selector "input[type='checkbox'][id$='_abc']", count: 2
    assert_selector "label[for$='_abc']", count: 2
  end

  def test_no_scope_keeps_default_input_ids
    render_inline(CheckboxesComponent.new(
      form: build_form,
      method: :checkboxes_field,
      collection: simple_collection,
      item_value_method: :value,
      item_label_method: :label,
      legend: "Pick some"
    ))
    assert_no_selector "input[type='checkbox'][id*='_abc']"
    assert_selector "input[type='checkbox']#component_test_model_checkboxes_field_yes"
    assert_selector "input[type='checkbox']#component_test_model_checkboxes_field_no"
  end

  def test_css_class_is_appended_to_root
    render_inline(CheckboxesComponent.new(
      form: build_form,
      method: :checkboxes_field,
      collection: simple_collection,
      item_value_method: :value,
      item_label_method: :label,
      legend: "Checkbox group",
      css_class: "mt-cfa-lg"
    ))
    assert_selector "fieldset.mt-cfa-lg"
  end
end
