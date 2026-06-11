# frozen_string_literal: true

require "test_helper"

# Tests that components with help/instruction text associate it with their
# input via aria-describedby (alongside the error message, in reading order),
# so screen readers announce the instruction when the field receives focus.
class HelpTextAssociationTest < ViewComponent::TestCase
  def model_with_error(method)
    ComponentTestModel.new.tap { |m| m.errors.add(method, "can't be blank") }
  end

  def help_id(method)
    build_form.field_id(method, :help)
  end

  def error_id(method)
    build_form.field_id(method, :error)
  end

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
    assert_equal help_id(:select_field), page.find("select")["aria-describedby"]
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
    render_inline(DatePickerComponent.new(
      form: build_form, method: :my_date, label: "DOB", label_day: "Day", label_month: "Month",
      label_month_select: "Select month", label_year: "Year", helper_text: "MM / DD / YYYY"
    ))
    fields = page.all("input[type='text'], select")
    assert_equal 3, fields.size
    fields.each { |field| assert_equal help_id(:my_date), field["aria-describedby"] }
  end
end
