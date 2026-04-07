# frozen_string_literal: true

require "test_helper"

class SubmitButtonComponentTest < ViewComponent::TestCase
  def test_renders_submit_button_with_label
    render_inline(SubmitButtonComponent.new(form: build_form, label: "Save"))
    assert_selector "input[type='submit'][value='Save']"
  end

  def test_primary_style_is_default
    render_inline(SubmitButtonComponent.new(form: build_form, label: "Save"))
    assert_selector "input.btn--primary"
  end

  def test_secondary_style
    render_inline(SubmitButtonComponent.new(form: build_form, label: "Save", style: :secondary))
    assert_selector "input.btn--secondary"
  end

  def test_invalid_style_raises
    assert_raises(ArgumentError) do
      SubmitButtonComponent.new(form: build_form, label: "Save", style: :invalid)
    end
  end
end
