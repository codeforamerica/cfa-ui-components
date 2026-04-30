# frozen_string_literal: true

require "test_helper"

# Tests that every form component correctly renders FormErrorsComponent
# when the underlying model has validation errors on the corresponding field.
class FormErrorsPropagationTest < ViewComponent::TestCase
  def test_text_field_renders_errors_from_model
    model = ComponentTestModel.new
    model.errors.add(:text_field, "can't be blank")

    render_inline(InputComponent.new(
      form: build_form(model), method: :text_field, label: "Name"
    ))

    assert_selector ".form_errors", text: "can't be blank"
  end

  def test_radio_buttons_renders_errors_from_model
    model = ComponentTestModel.new
    model.errors.add(:radio_field, "must be selected")

    render_inline(RadioButtonsComponent.new(
      form: build_form(model),
      method: :radio_field,
      collection: simple_collection,
      item_value_method: :value,
      item_label_method: :label,
      legend: "Pick one"
    ))

    assert_selector ".form_errors", text: "must be selected"
  end

  def test_checkboxes_renders_errors_from_model
    model = ComponentTestModel.new
    model.errors.add(:checkboxes_field, "must select at least one")

    render_inline(CheckboxesComponent.new(
      form: build_form(model),
      method: :checkboxes_field,
      collection: simple_collection,
      item_value_method: :value,
      item_label_method: :label,
      legend: "Pick some"
    ))

    assert_selector ".form_errors", text: "must select at least one"
  end

  def test_select_renders_errors_from_model
    model = ComponentTestModel.new
    model.errors.add(:select_field, "must be selected")

    render_inline(SelectComponent.new(
      form: build_form(model),
      method: :select_field,
      label: "Pick one",
      collection: simple_collection,
      item_value_method: :value,
      item_label_method: :label
    ))

    assert_selector ".form_errors", text: "must be selected"
  end

  def test_single_checkbox_renders_errors_from_model
    model = ComponentTestModel.new
    model.errors.add(:checkbox_field, "must be accepted")

    render_inline(SingleCheckboxComponent.new(
      form: build_form(model), method: :checkbox_field, label: "I agree"
    ))

    assert_selector ".form_errors", text: "must be accepted"
  end

  def test_combobox_renders_errors_from_model
    model = ComponentTestModel.new
    model.errors.add(:combobox_field, "must be selected")

    render_inline(ComboboxComponent.new(
      form: build_form(model),
      method: :combobox_field,
      label: "Choose one",
      collection: simple_collection,
      item_value_method: :value,
      item_label_method: :label
    ))

    assert_selector ".form_errors", text: "must be selected"
  end
end
