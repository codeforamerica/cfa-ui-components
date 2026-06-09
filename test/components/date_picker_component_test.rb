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

  def test_label_renders_as_visible_fieldset_legend
    render_inline(DatePickerComponent.new(
      form: build_form,
      method: :my_date,
      label: "Date of birth",
      label_day: "Day",
      label_month: "Month",
      label_month_select: "Select month",
      label_year: "Year"
    ))

    # DatePicker's label is the field's own visible label, so the legend is
    # visible (not sr-only) unlike the radio/checkbox group components.
    assert_selector "fieldset.fieldset-group > legend", text: "Date of birth"
    assert_no_selector "legend.sr-only"
  end

  def test_aria_labelledby_sets_fieldset_attribute_without_legend
    render_inline(DatePickerComponent.new(
      form: build_form,
      method: :my_date,
      label: "",
      label_day: "Day",
      label_month: "Month",
      label_month_select: "Select month",
      label_year: "Year",
      aria_labelledby: "external-heading"
    ))

    assert_selector "fieldset[aria-labelledby='external-heading']"
    assert_no_selector "legend"
  end

  def test_raises_when_label_blank_and_no_aria_labelledby
    assert_raises(ArgumentError) do
      DatePickerComponent.new(
        form: build_form,
        method: :my_date,
        label: "",
        label_day: "Day",
        label_month: "Month",
        label_month_select: "Select month",
        label_year: "Year"
      )
    end
  end
end
