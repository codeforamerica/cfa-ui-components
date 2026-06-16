# frozen_string_literal: true

require "test_helper"
require "active_model"

class DatePickerTestModel
  include ActiveModel::Model
  include ActiveModel::Attributes

  attribute :my_date
end

class DatePickerComponentTest < ViewComponent::TestCase
  def build_form
    f = nil
    vc_test_controller.view_context.form_with(url: "/", model: DatePickerTestModel.new) { |fb| f = fb }
    f
  end

  def test_label_for_attributes_match_input_ids
    render_inline(DatePickerComponent.new(
      form: build_form,
      method: :my_date,
      label: "Date of birth",
      label_day: "Day",
      label_month: "Month",
      label_month_select: "Select month",
      label_year: "Year"
    ))

    assert_selector "label[for='date_picker_test_model_my_date_2i']"
    assert_selector "label[for='date_picker_test_model_my_date_3i']"
    assert_selector "label[for='date_picker_test_model_my_date_1i']"
    assert_selector "select#date_picker_test_model_my_date_2i"
    assert_selector "input#date_picker_test_model_my_date_3i"
    assert_selector "input#date_picker_test_model_my_date_1i"
  end

  def test_css_class_is_appended_to_root
    render_inline(DatePickerComponent.new(
      form: build_form,
      method: :my_date,
      label: "Date of birth",
      label_day: "Day",
      label_month: "Month",
      label_month_select: "Select month",
      label_year: "Year",
      css_class: "mt-cfa-lg"
    ))
    assert_selector "div.mt-cfa-lg"
  end

  def test_input_attrs_are_forwarded_to_every_field
    render_inline(DatePickerComponent.new(
      form: build_form,
      method: :my_date,
      label: "Date of birth",
      label_day: "Day",
      label_month: "Month",
      label_month_select: "Select month",
      label_year: "Year",
      input_attrs: {autocomplete: "off"}
    ))

    assert_selector "select#date_picker_test_model_my_date_2i[autocomplete='off']"
    assert_selector "input#date_picker_test_model_my_date_3i[autocomplete='off']"
    assert_selector "input#date_picker_test_model_my_date_1i[autocomplete='off']"
  end
end
