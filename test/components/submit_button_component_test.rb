# frozen_string_literal: true

require "test_helper"

class SubmitButtonComponentTest < ViewComponent::TestCase
  def test_renders_submit_button_with_label
    render_inline(SubmitButtonComponent.new(form: build_form, label: "Save"))
    assert_selector "button[type='submit']", text: "Save"
  end

  def test_primary_variant_is_default
    render_inline(SubmitButtonComponent.new(form: build_form, label: "Save"))
    assert_selector "button.btn--primary"
  end

  def test_secondary_variant
    render_inline(SubmitButtonComponent.new(form: build_form, label: "Save", variant: :secondary))
    assert_selector "button.btn--secondary"
  end

  def test_invalid_variant_raises
    assert_raises(ArgumentError) do
      SubmitButtonComponent.new(form: build_form, label: "Save", variant: :invalid)
    end
  end

  def test_css_class_is_appended_without_dropping_base_classes
    render_inline(SubmitButtonComponent.new(form: build_form, label: "Save", css_class: "mt-cfa-lg"))
    assert_selector "button.btn.btn--large.btn--primary.mt-cfa-lg"
  end
end
