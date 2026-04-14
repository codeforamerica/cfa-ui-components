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

  def test_required_adds_class_to_label
    render_inline(TinComponent.new(form: build_form, method: :text_field, label: "Social Security Number", required: true))
    assert_selector "label.required"
  end

  def test_renders_show_toggle_checkbox
    render_inline(TinComponent.new(form: build_form, method: :text_field, label: "Social Security Number"))
    assert_selector "input[type='checkbox']"
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
end
