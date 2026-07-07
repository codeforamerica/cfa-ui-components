# frozen_string_literal: true

require "test_helper"

class SelectComponentTest < ViewComponent::TestCase
  def test_renders_label_and_options
    render_inline(SelectComponent.new(
      form: build_form,
      method: :select_field,
      label: "Pick one",
      collection: simple_collection,
      item_value_method: :value,
      item_label_method: :label
    ))

    assert_selector "label", text: "Pick one"
    assert_selector "[role='option']", text: "Yes"
    assert_selector "[role='option']", text: "No"
  end

  def test_renders_help_text
    render_inline(SelectComponent.new(
      form: build_form,
      method: :select_field,
      label: "Pick one",
      collection: simple_collection,
      item_value_method: :value,
      item_label_method: :label,
      help_text: "Select an option"
    ))
    assert_selector ".help_text", text: "Select an option"
  end

  def test_required_by_default_sets_aria_required_and_omits_optional_marker
    render_inline(SelectComponent.new(
      form: build_form,
      method: :select_field,
      label: "Pick one",
      collection: simple_collection,
      item_value_method: :value,
      item_label_method: :label
    ))
    assert_selector "label", text: "Pick one"
    assert_no_text "(optional)"
    assert_selector "[role='combobox'][aria-required='true']"
  end

  def test_optional_appends_optional_marker_and_omits_aria_required
    render_inline(SelectComponent.new(
      form: build_form,
      method: :select_field,
      label: "Pick one",
      collection: simple_collection,
      item_value_method: :value,
      item_label_method: :label,
      optional: true
    ))
    assert_selector "label", text: "Pick one (optional)"
    assert_no_selector "[role='combobox'][aria-required='true']"
    assert_selector "[role='combobox'][aria-required='false']"
  end

  def test_css_class_is_appended_to_root
    render_inline(SelectComponent.new(
      form: build_form,
      method: :select_field,
      label: "Pick one",
      collection: simple_collection,
      item_value_method: :value,
      item_label_method: :label,
      css_class: "mt-cfa-lg"
    ))
    assert_selector "div.cfa-stack-sm.mt-cfa-lg"
  end

  # The placeholder is the optional select's blank entry. The custom Alpine
  # widget renders it as a listbox <li> (not a native <option>), so assert on
  # the rendered option label.
  def test_renders_localized_placeholder_prompt
    render_inline(SelectComponent.new(
      form: build_form,
      method: :select_field,
      label: "Pick one",
      collection: simple_collection,
      item_value_method: :value,
      item_label_method: :label,
      optional: true
    ))
    assert_selector "span.option-label", text: "- Select -"
  end

  def test_placeholder_prompt_is_spanish_when_locale_is_es
    I18n.with_locale(:es) do
      render_inline(SelectComponent.new(
        form: build_form,
        method: :select_field,
        label: "Elige uno",
        collection: simple_collection,
        item_value_method: :value,
        item_label_method: :label,
        optional: true
      ))
    end
    assert_selector "span.option-label", text: "- Seleccionar -"
  end

  # The control is a custom Alpine combobox (button + listbox), not a native
  # <select>, so it carries its description association on the button itself.
  def test_help_text_is_associated_with_the_combobox_button
    render_inline(SelectComponent.new(
      form: build_form,
      method: :select_field,
      label: "Pick one",
      collection: simple_collection,
      item_value_method: :value,
      item_label_method: :label,
      help_text: "Select an option"
    ))
    help = page.find("p.help_text")
    assert_equal help["id"], page.find("[role='combobox']")["aria-describedby"]
  end

  # Parity with the other form field components: SelectComponent must accept
  # input_attrs without raising, even though its custom combobox has no native
  # field to forward them onto.
  def test_accepts_input_attrs_without_error
    render_inline(SelectComponent.new(
      form: build_form,
      method: :select_field,
      label: "Pick one",
      collection: simple_collection,
      item_value_method: :value,
      item_label_method: :label,
      input_attrs: {autocomplete: "off"}
    ))
    assert_selector "[role='combobox']"
  end
end
