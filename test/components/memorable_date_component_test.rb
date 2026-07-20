# frozen_string_literal: true

require "test_helper"
require "active_model"

class DatePickerTestModel
  include ActiveModel::Model
  include ActiveModel::Attributes

  attribute :my_date, :date
end

# Mimics an ActiveRecord object after a failed multiparameter date cast: the
# cast attribute is nil, but attributes_before_type_cast still holds the raw
# {1i,2i,3i} parts the user submitted. Plain ActiveModel::Attributes supports
# neither multiparameter assignment nor attributes_before_type_cast, so we
# supply them by hand.
class InvalidDateTestModel
  include ActiveModel::Model
  include ActiveModel::Attributes

  attribute :my_date, :date

  def initialize(raw_parts)
    super()
    @raw_parts = raw_parts
  end

  def attributes_before_type_cast
    {"my_date" => @raw_parts}
  end
end

class MemorableDateComponentTest < ViewComponent::TestCase
  def build_form(model = DatePickerTestModel.new)
    f = nil
    vc_test_controller.view_context.form_with(url: "/", model:) { |fb| f = fb }
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

  # TEF-829: when the user submits an unparseable date (e.g. Feb 31), Rails
  # casts my_date to nil but keeps the raw parts in attributes_before_type_cast.
  # The fields must re-render exactly what the user typed instead of going blank.
  def test_invalid_date_re_renders_the_users_raw_input
    model = InvalidDateTestModel.new({1 => "2020", 2 => "2", 3 => "31"})
    assert_nil model.my_date # the cast failed

    render_inline(MemorableDateComponent.new(form: build_form(model), method: :my_date, label: "Date of birth"))

    assert_selector "input#invalid_date_test_model_my_date_3i[value='31']"
    assert_selector "input#invalid_date_test_model_my_date_1i[value='2020']"
    assert_selector "input[name='invalid_date_test_model[my_date(2i)]'][value='2']", visible: :all
  end

  def test_valid_date_renders_from_the_cast_value
    model = DatePickerTestModel.new(my_date: Date.new(1999, 3, 7))

    render_inline(MemorableDateComponent.new(form: build_form(model), method: :my_date, label: "Date of birth"))

    assert_selector "input#date_picker_test_model_my_date_3i[value='7']"
    assert_selector "input#date_picker_test_model_my_date_1i[value='1999']"
    assert_selector "input[name='date_picker_test_model[my_date(2i)]'][value='3']", visible: :all
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
