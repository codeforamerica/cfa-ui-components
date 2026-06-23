# frozen_string_literal: true

require "test_helper"

# Tests that form components associate their input(s) with their description
# text (help, error, warning) via aria-describedby, and mark single inputs
# aria-invalid, so screen readers announce the description when the field
# receives focus. Each referenced id must resolve to an element on the page,
# in DOM/reading order (help, error, warning).
class AriaAssociationTest < ViewComponent::TestCase
  def model_with_error(method)
    ComponentTestModel.new.tap { |m| m.errors.add(method, "can't be blank") }
  end

  def help_id(method)
    build_form.field_id(method, :help)
  end

  def error_id(method)
    build_form.field_id(method, :error)
  end

  def warning_id(method)
    build_form.field_id(method, :warning)
  end

  # --- Errors -------------------------------------------------------------

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

  # SelectComponent is a custom Alpine combobox (button + listbox), not a native
  # <select>, so the association lives on the button.
  def test_select_describedby_points_at_error
    render_inline(SelectComponent.new(
      form: build_form(model_with_error(:select_field)), method: :select_field,
      label: "Pick one", collection: simple_collection,
      item_value_method: :value, item_label_method: :label
    ))
    button = page.find("[role='combobox']")
    assert_equal "true", button["aria-invalid"]
    assert_equal error_id(:select_field), button["aria-describedby"]
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
    render_inline(MemorableDateComponent.new(
      form: build_form(model_with_error(:my_date)), method: :my_date,
      label: "Date of birth", label_day: "Day", label_month: "Month",
      label_month_select: "Select month", label_year: "Year"
    ))
    # day + year are native text inputs; the month picker is a custom combobox button.
    fields = page.all("input[type='text'], [role='combobox']")
    assert_equal 3, fields.size
    fields.each do |field|
      assert_equal "true", field["aria-invalid"]
      assert_equal error_id(:my_date), field["aria-describedby"]
    end
  end

  # Groups carry the association on the <fieldset> (not each option), so the
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

  # --- Help text ----------------------------------------------------------

  def test_text_field_describedby_points_at_help_text
    render_inline(InputComponent.new(form: build_form, method: :text_field, label: "Name", help_text: "Your legal name"))
    input = page.find("input[type='text']")
    assert_selector "p.help_text##{help_id(:text_field)}", text: "Your legal name"
    assert_equal help_id(:text_field), input["aria-describedby"]
    assert_nil input["aria-invalid"], "valid field should not be marked invalid"
  end

  def test_text_field_describedby_lists_help_then_error
    render_inline(InputComponent.new(form: build_form(model_with_error(:text_field)), method: :text_field, label: "Name", help_text: "Your legal name"))
    input = page.find("input[type='text']")
    assert_equal "#{help_id(:text_field)} #{error_id(:text_field)}", input["aria-describedby"]
    assert_equal "true", input["aria-invalid"]
  end

  def test_select_describedby_points_at_help_text
    render_inline(SelectComponent.new(
      form: build_form, method: :select_field, label: "Pick", help_text: "Choose carefully",
      collection: simple_collection, item_value_method: :value, item_label_method: :label
    ))
    assert_equal help_id(:select_field), page.find("[role='combobox']")["aria-describedby"]
  end

  def test_currency_field_associates_help_and_error
    render_inline(InputCurrencyComponent.new(
      form: build_form(model_with_error(:text_field)), method: :text_field, label: "Amount", help_text: "Whole dollars"
    ))
    input = page.find("input")
    assert_equal "true", input["aria-invalid"]
    assert_equal "#{help_id(:text_field)} #{error_id(:text_field)}", input["aria-describedby"]
  end

  def test_tin_field_associates_error
    render_inline(TinComponent.new(
      form: build_form(model_with_error(:text_field)), method: :text_field, label: "SSN"
    ))
    input = page.find("input[x-ref='input']")
    assert_equal "true", input["aria-invalid"]
    assert_equal error_id(:text_field), input["aria-describedby"]
  end

  def test_date_picker_inputs_describedby_point_at_help_text
    render_inline(MemorableDateComponent.new(
      form: build_form, method: :my_date, label: "DOB", label_day: "Day", label_month: "Month",
      label_month_select: "Select month", label_year: "Year", helper_text: "MM / DD / YYYY"
    ))
    # day + year are native text inputs; the month picker is a custom combobox button.
    fields = page.all("input[type='text'], [role='combobox']")
    assert_equal 3, fields.size
    fields.each { |field| assert_equal help_id(:my_date), field["aria-describedby"] }
  end

  # --- Warnings (radio/checkbox groups) -----------------------------------

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
    assert_equal warning_id(:checkboxes_field), page.find("fieldset")["aria-describedby"]
  end
end
