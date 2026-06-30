# frozen_string_literal: true

require "test_helper"
require "active_model"

class DatePickerTestModel
  include ActiveModel::Model
  include ActiveModel::Attributes

  attribute :my_date
end

class MemorableDateComponentTest < ViewComponent::TestCase
  def build_form
    f = nil
    vc_test_controller.view_context.form_with(url: "/", model: DatePickerTestModel.new) { |fb| f = fb }
    f
  end

  def test_label_for_attributes_match_input_ids
    render_inline(MemorableDateComponent.new(
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
    assert_selector "button#date_picker_test_model_my_date_2i[aria-haspopup='listbox']"
    assert_selector "input#date_picker_test_model_my_date_3i"
    assert_selector "input#date_picker_test_model_my_date_1i"
  end

  def test_label_renders_as_visible_fieldset_legend
    render_inline(MemorableDateComponent.new(
      form: build_form,
      method: :my_date,
      label: "Date of birth",
      label_day: "Day",
      label_month: "Month",
      label_month_select: "Select month",
      label_year: "Year"
    ))

    # MemorableDate's label is the field's own visible label, so the legend is
    # visible (not sr-only) unlike the radio/checkbox group components.
    assert_selector "fieldset.memorable-date > legend", text: "Date of birth"
    assert_no_selector "legend.sr-only"
  end

  def test_aria_labelledby_sets_fieldset_attribute_without_legend
    render_inline(MemorableDateComponent.new(
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
      MemorableDateComponent.new(
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

  def test_css_class_is_appended_to_root
    render_inline(MemorableDateComponent.new(
      form: build_form,
      method: :my_date,
      label: "Date of birth",
      label_day: "Day",
      label_month: "Month",
      label_month_select: "Select month",
      label_year: "Year",
      css_class: "mt-cfa-lg"
    ))
    assert_selector "fieldset.mt-cfa-lg"
  end

  # The month picker is a custom Alpine combobox (button + listbox), not a native
  # field, so input_attrs forward to the native day/year text inputs only.
  def test_input_attrs_are_forwarded_to_the_native_day_and_year_fields
    render_inline(MemorableDateComponent.new(
      form: build_form,
      method: :my_date,
      label: "Date of birth",
      label_day: "Day",
      label_month: "Month",
      label_month_select: "Select month",
      label_year: "Year",
      input_attrs: {autocomplete: "off"}
    ))

    assert_selector "button#date_picker_test_model_my_date_2i[aria-haspopup='listbox']"
    assert_selector "input#date_picker_test_model_my_date_3i[autocomplete='off']"
    assert_selector "input#date_picker_test_model_my_date_1i[autocomplete='off']"
  end

  def test_input_attrs_aria_merges_with_the_fields_own_aria
    render_inline(MemorableDateComponent.new(
      form: build_form,
      method: :my_date,
      label: "Date of birth",
      label_day: "Day",
      label_month: "Month",
      label_month_select: "Select month",
      label_year: "Year",
      input_attrs: {aria: {describedby: "dob-hint"}}
    ))

    # The component's own aria-invalid survives, and the caller's aria-describedby is added.
    assert_selector "input#date_picker_test_model_my_date_3i[aria-invalid][aria-describedby='dob-hint']"
  end

  def test_sub_labels_default_to_localized_strings_when_omitted
    render_inline(MemorableDateComponent.new(form: build_form, method: :my_date, label: "Date of birth"))

    assert_selector "label", text: "Month"
    assert_selector "label", text: "Day"
    assert_selector "label", text: "Year"
    assert_selector "span.option-label", text: "- Select -"
  end

  def test_sub_labels_default_to_spanish_when_locale_is_es
    I18n.with_locale(:es) do
      render_inline(MemorableDateComponent.new(form: build_form, method: :my_date, label: "Fecha de nacimiento"))
    end

    assert_selector "label", text: "Mes"
    assert_selector "label", text: "Día"
    assert_selector "label", text: "Año"
    assert_selector "span.option-label", text: "- Seleccionar -"
  end

  def test_sub_labels_can_be_overridden
    render_inline(MemorableDateComponent.new(form: build_form, method: :my_date, label: "Date of birth", label_day: "DD"))

    assert_selector "label", text: "DD"
  end

  def test_input_attrs_id_raises_because_it_would_collide_across_fields
    error = assert_raises(ArgumentError) do
      MemorableDateComponent.new(
        form: build_form,
        method: :my_date,
        label: "Date of birth",
        label_day: "Day",
        label_month: "Month",
        label_month_select: "Select month",
        label_year: "Year",
        input_attrs: {id: "dob"}
      )
    end
    assert_match(/id/, error.message)
  end

  def test_month_options_render_in_english_by_default
    render_inline(MemorableDateComponent.new(
      form: build_form,
      method: :my_date,
      label: "Date of birth",
      label_day: "Day",
      label_month: "Month",
      label_month_select: "Select month",
      label_year: "Year"
    ))

    assert_selector "span.option-label", text: "January"
    assert_selector "span.option-label", text: "December"
  end

  def test_month_options_render_in_spanish_when_locale_is_es
    I18n.with_locale(:es) do
      render_inline(MemorableDateComponent.new(
        form: build_form,
        method: :my_date,
        label: "Fecha de nacimiento",
        label_day: "Día",
        label_month: "Mes",
        label_month_select: "Seleccionar mes",
        label_year: "Año"
      ))
    end

    assert_selector "span.option-label", text: "enero"
    assert_selector "span.option-label", text: "diciembre"
  end
end
