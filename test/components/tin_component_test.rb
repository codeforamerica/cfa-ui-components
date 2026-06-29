# frozen_string_literal: true

require "test_helper"

class TinComponentTest < ViewComponent::TestCase
  def test_renders_label_and_input
    render_inline(TinComponent.new(form: build_form, method: :text_field, label: "Social Security Number"))
    assert_selector "label", text: "Social Security Number"
    assert_selector "input[type='text']"
  end

  def test_renders_help_text
    render_inline(TinComponent.new(form: build_form, method: :text_field, label: "Social Security Number", help_text: "Enter your SSN"))
    assert_selector ".help_text", text: "Enter your SSN"
  end

  def test_required_by_default_sets_aria_required_and_omits_optional_marker
    render_inline(TinComponent.new(form: build_form, method: :text_field, label: "Social Security Number"))
    assert_selector "label", text: "Social Security Number"
    assert_no_text "(optional)"
    assert_selector "input[type='text'][aria-required='true']"
  end

  def test_optional_appends_optional_marker_and_omits_aria_required
    render_inline(TinComponent.new(form: build_form, method: :text_field, label: "Social Security Number", optional: true))
    assert_selector "label", text: "Social Security Number (optional)"
    assert_no_selector "input[type='text'][aria-required]"
  end

  def test_renders_show_toggle_checkbox
    render_inline(TinComponent.new(form: build_form, method: :text_field, label: "Social Security Number"))
    assert_selector "input[type='checkbox']"
  end

  def test_show_toggle_disables_autocomplete_so_browser_does_not_restore_checked_state_on_back_button
    render_inline(TinComponent.new(form: build_form, method: :text_field, label: "Social Security Number"))
    assert_selector "input[type='checkbox'][autocomplete='off']"
  end

  def test_input_has_tin_mask
    render_inline(TinComponent.new(form: build_form, method: :text_field, label: "Social Security Number"))
    assert_selector "input[x-mask='999-99-9999']"
  end

  def test_input_has_tin_placeholder
    render_inline(TinComponent.new(form: build_form, method: :text_field, label: "Social Security Number"))
    assert_selector "input[placeholder='000-00-0000']"
  end

  def test_renders_screen_reader_announcement_region
    render_inline(TinComponent.new(form: build_form, method: :text_field, label: "Social Security Number"))
    assert_selector "[role='alert'][aria-atomic='true'].sr-only"
  end

  def test_input_attrs_are_forwarded_to_the_field
    render_inline(TinComponent.new(form: build_form, method: :text_field, label: "Social Security Number", input_attrs: {autocomplete: "off"}))
    assert_selector "input[x-ref='input'][autocomplete='off']"
  end

  # --- Confirmation field ---

  def test_renders_confirmation_field_when_confirmation_method_given
    render_inline(TinComponent.new(
      form: build_form,
      method: :text_field,
      label: "Social Security Number",
      confirmation_method: :text_field_confirmation,
      confirmation_label: "Confirm Social Security Number"
    ))
    assert_selector "label", text: "Social Security Number"
    assert_selector "label", text: "Confirm Social Security Number"
    assert_selector "input[name='component_test_model[text_field]']"
    assert_selector "input[name='component_test_model[text_field_confirmation]']"
  end

  def test_no_obfuscation_when_value_blank
    render_inline(TinComponent.new(form: build_form, method: :text_field, label: "Social Security Number"))
    assert_no_text "•••"
    assert_no_selector "button", text: "Edit"
    assert_no_selector "button", text: "Cancel"
  end

  # --- Obfuscated view on revisit (saved value, no errors) ---

  def saved_model
    ComponentTestModel.new(text_field: "123456789")
  end

  def test_shows_obfuscated_value_with_last_four_when_value_saved
    render_inline(TinComponent.new(form: build_form(saved_model), method: :text_field, label: "Social Security Number"))
    assert_text "•••-••-6789"
  end

  def test_shows_edit_button_as_secondary_small_when_value_saved
    render_inline(TinComponent.new(form: build_form(saved_model), method: :text_field, label: "Social Security Number"))
    assert_selector "button.btn.btn--secondary.btn--small", text: "Edit"
  end

  def test_shows_cancel_button_when_value_saved
    render_inline(TinComponent.new(form: build_form(saved_model), method: :text_field, label: "Social Security Number"))
    assert_selector "button.btn.btn--secondary.btn--small", text: "Cancel"
  end

  def test_does_not_prefill_saved_value_into_the_input_on_revisit
    render_inline(TinComponent.new(form: build_form(saved_model), method: :text_field, label: "Social Security Number"))
    assert_no_selector "input[value='123456789']"
    assert_selector "input[data-tin-input][value='']"
  end

  def test_full_value_is_never_present_in_the_rendered_markup_on_revisit
    render_inline(TinComponent.new(form: build_form(saved_model), method: :text_field, label: "Social Security Number"))
    refute_includes page.native.to_s, "123456789"
  end

  def test_inputs_disabled_on_revisit_so_saved_value_is_not_submitted
    render_inline(TinComponent.new(form: build_form(saved_model), method: :text_field, label: "Social Security Number"))
    assert_selector "input[data-tin-input][disabled]"
    assert_includes page.native.to_s, 'x-bind:disabled="!editing"'
  end

  def test_starts_in_obfuscated_view_on_clean_revisit
    render_inline(TinComponent.new(form: build_form(saved_model), method: :text_field, label: "Social Security Number"))
    assert_selector "div[x-data*='editing: false']"
  end

  def test_screen_reader_text_describes_last_four
    render_inline(TinComponent.new(form: build_form(saved_model), method: :text_field, label: "Social Security Number"))
    assert_selector ".sr-only", text: "ending in 6789"
  end

  # --- Editing after a failed submit (saved value + errors) ---

  def test_starts_in_edit_mode_and_preserves_value_when_errors_present
    model = saved_model
    model.errors.add(:text_field, "is invalid")
    render_inline(TinComponent.new(form: build_form(model), method: :text_field, label: "Social Security Number"))
    assert_selector "div[x-data*='editing: true']"
    assert_selector "input[data-tin-input][value='123456789']"
  end
end
