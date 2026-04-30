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

  def test_small_variant_uses_smaller_box
    render_inline(CheckboxesComponent.new(
      form: build_form,
      method: :checkboxes_field,
      collection: simple_collection,
      item_value_method: :value,
      item_label_method: :label,
      small: true
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
      item_label_method: :label
    ))
    assert_selector "input[type='checkbox'].h-6.w-6", count: 2
  end

  def test_warning_message_renders_warning_state
    render_inline(CheckboxesComponent.new(
      form: build_form,
      method: :checkboxes_field,
      collection: simple_collection,
      item_value_method: :value,
      item_label_method: :label,
      warning_message: "Heads up!"
    ))
    assert_selector ".form_warning", text: "Heads up!"
    assert_selector "input[type='checkbox'].border-border-warning", count: 2
  end

  def test_warning_suppressed_when_error_present
    model = ComponentTestModel.new
    model.errors.add(:checkboxes_field, "is required")
    render_inline(CheckboxesComponent.new(
      form: build_form(model),
      method: :checkboxes_field,
      collection: simple_collection,
      item_value_method: :value,
      item_label_method: :label,
      warning_message: "Heads up!"
    ))
    assert_selector ".form_errors"
    assert_no_selector ".form_warning"
  end

  def test_indeterminate_sets_alpine_init_on_matching_items
    render_inline(CheckboxesComponent.new(
      form: build_form,
      method: :checkboxes_field,
      collection: simple_collection,
      item_value_method: :value,
      item_label_method: :label,
      indeterminate: ["yes"]
    ))
    assert_selector "input[type='checkbox'][value='yes'][x-init='$el.indeterminate = true']"
    assert_no_selector "input[type='checkbox'][value='no'][x-init]"
  end

  def test_unique_id_namespaces_input_ids_and_label_for
    render_inline(CheckboxesComponent.new(
      form: build_form,
      method: :checkboxes_field,
      collection: simple_collection,
      item_value_method: :value,
      item_label_method: :label,
      unique_id: "abc"
    ))
    assert_selector "input[type='checkbox'][id$='_abc']", count: 2
    assert_selector "label[for$='_abc']", count: 2
  end

  def test_no_unique_id_keeps_default_input_ids
    render_inline(CheckboxesComponent.new(
      form: build_form,
      method: :checkboxes_field,
      collection: simple_collection,
      item_value_method: :value,
      item_label_method: :label
    ))
    assert_no_selector "input[type='checkbox'][id*='_abc']"
    assert_selector "input[type='checkbox']#component_test_model_checkboxes_field_yes"
    assert_selector "input[type='checkbox']#component_test_model_checkboxes_field_no"
  end
end
