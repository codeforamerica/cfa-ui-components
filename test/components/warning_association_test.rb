# frozen_string_literal: true

require "test_helper"

# Tests that radio/checkbox groups associate their warning message with the
# <fieldset> via aria-describedby (alongside the error, in DOM order), so it
# is announced when focus enters the group — WCAG 1.3.1.
class WarningAssociationTest < ViewComponent::TestCase
  def model_with_error(method)
    ComponentTestModel.new.tap { |m| m.errors.add(method, "can't be blank") }
  end

  def error_id(method)
    build_form.field_id(method, :error)
  end

  def warning_id(method)
    build_form.field_id(method, :warning)
  end

  def test_radio_group_describedby_points_at_warning
    render_inline(RadioButtonsComponent.new(
      form: build_form, method: :radio_field, collection: simple_collection,
      item_value_method: :value, item_label_method: :label,
      legend: "Pick one", warning_message: "Heads up"
    ))
    fieldset = page.find("fieldset")
    assert_equal warning_id(:radio_field), fieldset["aria-describedby"]
    assert_selector "p.form_warning##{warning_id(:radio_field)}", text: "Heads up"
  end

  def test_radio_group_describedby_lists_error_then_warning
    render_inline(RadioButtonsComponent.new(
      form: build_form(model_with_error(:radio_field)), method: :radio_field,
      collection: simple_collection, item_value_method: :value, item_label_method: :label,
      legend: "Pick one", warning_message: "Heads up"
    ))
    assert_equal "#{error_id(:radio_field)} #{warning_id(:radio_field)}",
      page.find("fieldset")["aria-describedby"]
  end

  def test_checkbox_group_describedby_points_at_warning
    render_inline(CheckboxesComponent.new(
      form: build_form, method: :checkboxes_field, collection: simple_collection,
      item_value_method: :value, item_label_method: :label,
      legend: "Pick some", warning_message: "Heads up"
    ))
    fieldset = page.find("fieldset")
    assert_equal warning_id(:checkboxes_field), fieldset["aria-describedby"]
    assert_selector "p.form_warning##{warning_id(:checkboxes_field)}", text: "Heads up"
  end
end
