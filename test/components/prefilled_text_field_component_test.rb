# frozen_string_literal: true

require "test_helper"

class PrefilledTextFieldComponentTest < ViewComponent::TestCase
  def test_renders_text_and_label
    render_inline(PrefilledTextFieldComponent.new(text: "John", label: "Full name"))
    assert_selector "span", text: "Full name"
    assert_selector "span", text: "John"
  end

  def test_currency_style_formats_with_dollar_sign_and_delimiter
    render_inline(PrefilledTextFieldComponent.new(text: 1234, label: "Amount", style: :currency))
    assert_selector "span", text: "$1,234"
  end

  def test_invalid_style_raises
    assert_raises(ArgumentError) do
      PrefilledTextFieldComponent.new(text: "foo", label: "bar", style: :invalid)
    end
  end
end
