# frozen_string_literal: true

require "test_helper"

# Tests that form components associate their input(s) with the error message
# via aria-describedby (and mark single inputs aria-invalid), so screen readers
# announce the error when the field receives focus. The described-by id must
# resolve to the FormErrorsComponent message actually on the page.
class ErrorAssociationTest < ViewComponent::TestCase
  def model_with_error(method)
    ComponentTestModel.new.tap { |m| m.errors.add(method, "can't be blank") }
  end

  def error_id(method)
    build_form.field_id(method, :error)
  end

  def test_form_errors_component_renders_stable_id
    render_inline(FormErrorsComponent.new(form: build_form(model_with_error(:text_field)), method: :text_field))
    assert_selector "p.form_errors##{error_id(:text_field)}", text: "can't be blank"
  end

  def test_text_field_describedby_points_at_error
    render_inline(InputComponent.new(form: build_form(model_with_error(:text_field)), method: :text_field, label: "Name"))
    input = page.find("input[type='text']")
    assert_equal "true", input["aria-invalid"]
    assert_equal error_id(:text_field), input["aria-describedby"]
    assert_selector "##{input["aria-describedby"]}", text: "can't be blank"
  end

  def test_text_field_has_no_error_attrs_when_valid
    render_inline(InputComponent.new(form: build_form, method: :text_field, label: "Name"))
    input = page.find("input[type='text']")
    assert_nil input["aria-invalid"]
    assert_nil input["aria-describedby"]
  end

  def test_select_describedby_points_at_error
    render_inline(SelectComponent.new(
      form: build_form(model_with_error(:select_field)), method: :select_field,
      label: "Pick one", collection: simple_collection,
      item_value_method: :value, item_label_method: :label
    ))
    select = page.find("select")
    assert_equal "true", select["aria-invalid"]
    assert_equal error_id(:select_field), select["aria-describedby"]
  end

  def test_single_checkbox_describedby_points_at_error
    render_inline(SingleCheckboxComponent.new(
      form: build_form(model_with_error(:checkbox_field)), method: :checkbox_field, label: "I agree"
    ))
    checkbox = page.find("input[type='checkbox']")
    assert_equal "true", checkbox["aria-invalid"]
    assert_equal error_id(:checkbox_field), checkbox["aria-describedby"]
  end

  def test_combobox_select_describedby_points_at_error
    render_inline(ComboboxComponent.new(
      form: build_form(model_with_error(:combobox_field)), method: :combobox_field,
      label: "Choose", collection: simple_collection,
      item_value_method: :value, item_label_method: :label
    ))
    select = page.find("select")
    assert_equal "true", select["aria-invalid"]
    assert_equal error_id(:combobox_field), select["aria-describedby"]
  end

  def test_date_picker_inputs_describedby_point_at_error
    render_inline(DatePickerComponent.new(
      form: build_form(model_with_error(:my_date)), method: :my_date,
      label: "Date of birth", label_day: "Day", label_month: "Month",
      label_month_select: "Select month", label_year: "Year"
    ))
    fields = page.all("input[type='text'], select")
    assert_equal 3, fields.size
    fields.each do |field|
      assert_equal "true", field["aria-invalid"]
      assert_equal error_id(:my_date), field["aria-describedby"]
    end
  end

  # Groups: the fieldset (not each option) carries the association, so the
  # error is announced once when focus enters the group.
  def test_radio_group_fieldset_describedby_points_at_error
    render_inline(RadioButtonsComponent.new(
      form: build_form(model_with_error(:radio_field)), method: :radio_field,
      collection: simple_collection, item_value_method: :value,
      item_label_method: :label, legend: "Pick one"
    ))
    fieldset = page.find("fieldset")
    assert_equal error_id(:radio_field), fieldset["aria-describedby"]
    assert_selector "##{fieldset["aria-describedby"]}", text: "can't be blank"
  end

  def test_radio_group_fieldset_has_no_describedby_when_valid
    render_inline(RadioButtonsComponent.new(
      form: build_form, method: :radio_field,
      collection: simple_collection, item_value_method: :value,
      item_label_method: :label, legend: "Pick one"
    ))
    assert_nil page.find("fieldset")["aria-describedby"]
  end

  def test_checkbox_group_fieldset_describedby_points_at_error
    render_inline(CheckboxesComponent.new(
      form: build_form(model_with_error(:checkboxes_field)), method: :checkboxes_field,
      collection: simple_collection, item_value_method: :value,
      item_label_method: :label, legend: "Pick some"
    ))
    fieldset = page.find("fieldset")
    assert_equal error_id(:checkboxes_field), fieldset["aria-describedby"]
  end
end
