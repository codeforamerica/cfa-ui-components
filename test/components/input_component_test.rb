# frozen_string_literal: true

require "test_helper"

class InputComponentTest < ViewComponent::TestCase
  def test_renders_label_and_input
    render_inline(InputComponent.new(form: build_form, method: :text_field, label: "Full name"))
    assert_selector "label", text: "Full name"
    assert_selector "input[type='text']"
  end

  def test_renders_help_text
    render_inline(InputComponent.new(form: build_form, method: :text_field, label: "Full name", help_text: "Enter your full name"))
    assert_selector ".help_text", text: "Enter your full name"
  end

  def test_required_by_default_sets_aria_required_and_omits_optional_marker
    render_inline(InputComponent.new(form: build_form, method: :text_field, label: "Full name"))
    assert_selector "label", text: "Full name"
    assert_no_text "(optional)"
    assert_selector "input[type='text'][aria-required='true']"
  end

  def test_optional_appends_optional_marker_and_omits_aria_required
    render_inline(InputComponent.new(form: build_form, method: :text_field, label: "Full name", optional: true))
    assert_selector "label", text: "Full name (optional)"
    assert_no_selector "input[aria-required]"
  end

  def test_css_class_is_appended_to_root
    render_inline(InputComponent.new(form: build_form, method: :text_field, label: "Full name", css_class: "mt-cfa-lg"))
    assert_selector "div.cfa-stack-sm.mt-cfa-lg"
  end

  def test_input_attrs_are_forwarded_to_the_field
    render_inline(InputComponent.new(form: build_form, method: :text_field, label: "Full name", input_attrs: {inputmode: "tel", autocomplete: "tel"}))
    assert_selector "input[inputmode='tel'][autocomplete='tel']"
  end

  def test_input_attrs_class_augments_rather_than_clobbers_field_classes
    render_inline(InputComponent.new(form: build_form, method: :text_field, label: "Full name", input_attrs: {class: "my-custom-class"}))
    assert_selector "input.w-full.max-w-sm.my-custom-class"
  end

  def test_renders_confirmation_field_when_confirmation_method_given
    render_inline(InputComponent.new(
      form: build_form,
      method: :text_field,
      label: "Routing number",
      confirmation_method: :text_field_confirmation,
      confirmation_label: "Confirm routing number"
    ))
    assert_selector "label", text: "Routing number"
    assert_selector "label", text: "Confirm routing number"
    assert_selector "input[name='component_test_model[text_field]']"
    assert_selector "input[name='component_test_model[text_field_confirmation]']"
  end

  def test_input_attrs_are_forwarded_to_every_field
    render_inline(InputComponent.new(
      form: build_form,
      method: :text_field,
      label: "Routing number",
      confirmation_method: :text_field_confirmation,
      confirmation_label: "Confirm routing number",
      input_attrs: {inputmode: "numeric", autocomplete: "off"}
    ))
    assert_selector "input[name='component_test_model[text_field]'][inputmode='numeric'][autocomplete='off']"
    assert_selector "input[name='component_test_model[text_field_confirmation]'][inputmode='numeric'][autocomplete='off']"
  end

  # --- Obfuscation: nothing saved yet ---

  def test_no_obfuscation_markup_when_value_blank
    render_inline(InputComponent.new(form: build_form, method: :text_field, label: "Routing number", obfuscate: true))
    assert_no_text "•••"
    assert_no_selector "button", text: "Edit"
    assert_no_selector "button", text: "Cancel"
    assert_selector "input[name='component_test_model[text_field]']:not([disabled])"
  end

  # --- Obfuscated view on revisit (saved value, no errors) ---

  def saved_form
    build_form(ComponentTestModel.new(text_field: "123456789"))
  end

  def test_shows_obfuscated_value_with_last_four_when_value_saved
    render_inline(InputComponent.new(form: saved_form, method: :text_field, label: "Routing number", obfuscate: true))
    assert_text "•••••6789"
  end

  def test_shows_edit_button_as_secondary_small_when_value_saved
    render_inline(InputComponent.new(form: saved_form, method: :text_field, label: "Routing number", obfuscate: true))
    assert_selector "button.btn.btn--secondary.btn--small", text: "Edit"
    assert_no_selector ".translation_missing"
  end

  def test_shows_cancel_button_when_value_saved
    render_inline(InputComponent.new(form: saved_form, method: :text_field, label: "Routing number", obfuscate: true))
    assert_selector "button.btn.btn--secondary.btn--small", text: "Cancel"
    assert_no_selector ".translation_missing"
  end

  def test_edit_and_cancel_buttons_are_translated_in_spanish
    I18n.with_locale(:es) do
      render_inline(InputComponent.new(form: saved_form, method: :text_field, label: "Routing number", obfuscate: true))
    end
    assert_selector "button", text: "Editar"
    assert_selector "button", text: "Cancelar"
    assert_no_selector ".translation_missing"
  end

  def test_does_not_prefill_saved_value_into_the_input_on_revisit
    render_inline(InputComponent.new(form: saved_form, method: :text_field, label: "Routing number", obfuscate: true))
    assert_no_selector "input[value='123456789']"
    assert_selector "input[data-obfuscated-input][value='']"
  end

  def test_full_value_is_never_present_in_the_rendered_markup_on_revisit
    render_inline(InputComponent.new(form: saved_form, method: :text_field, label: "Routing number", obfuscate: true))
    refute_includes page.native.to_s, "123456789"
  end

  def test_inputs_disabled_on_revisit_so_saved_value_is_not_submitted
    render_inline(InputComponent.new(form: saved_form, method: :text_field, label: "Routing number", obfuscate: true))
    assert_selector "input[data-obfuscated-input][disabled]"
    assert_includes page.native.to_s, 'x-bind:disabled="!editing"'
  end

  def test_starts_in_obfuscated_view_on_clean_revisit
    render_inline(InputComponent.new(form: saved_form, method: :text_field, label: "Routing number", obfuscate: true))
    assert_selector "div[x-data*='editing: false']"
  end

  def test_screen_reader_text_describes_last_four
    render_inline(InputComponent.new(form: saved_form, method: :text_field, label: "Routing number", obfuscate: true))
    assert_selector ".sr-only", text: "ending in 6789"
  end

  def test_obfuscation_preserves_trailing_letters_for_alphanumeric_ids
    form = build_form(ComponentTestModel.new(text_field: "D123456X"))
    render_inline(InputComponent.new(form:, method: :text_field, label: "ID number", obfuscate: true))
    assert_text "•••••456X"
  end

  def test_starts_in_edit_mode_and_preserves_value_when_errors_present
    model = ComponentTestModel.new(text_field: "123456789")
    model.errors.add(:text_field, "is invalid")
    render_inline(InputComponent.new(form: build_form(model), method: :text_field, label: "Routing number", obfuscate: true))
    assert_selector "div[x-data*='editing: true']"
    assert_selector "input[data-obfuscated-input][value='123456789']"
  end

  def test_grouped_obfuscation_omits_its_own_toggle_and_buttons
    render_inline(InputComponent.new(form: saved_form, method: :text_field, label: "Routing number", obfuscate: true, edit_group: true))
    assert_no_selector "[x-data]"
    assert_no_selector "button", text: "Edit"
    assert_no_selector "button", text: "Cancel"
  end

  def test_grouped_obfuscation_shows_summary_and_inputs_bound_to_ambient_editing
    render_inline(InputComponent.new(form: saved_form, method: :text_field, label: "Routing number", obfuscate: true, edit_group: true))
    assert_text "•••••6789"
    assert_selector "div[x-show='!editing']"
    assert_selector "div[x-show='editing']"
    assert_selector "input[data-obfuscated-input]"
    assert_includes page.native.to_s, 'x-bind:disabled="!editing"'
  end

  def test_grouped_obfuscation_honors_editing_initially_override
    render_inline(InputComponent.new(form: saved_form, method: :text_field, label: "Routing number", obfuscate: true, edit_group: true, editing_initially: true))
    assert_selector "input[data-obfuscated-input]:not([disabled])"
    assert_no_selector "input[value='123456789']"
  end
end
