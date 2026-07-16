# frozen_string_literal: true

require "test_helper"

class PrefilledTextFieldComponentTest < ViewComponent::TestCase
  def test_renders_text_and_label_as_description_list
    render_inline(PrefilledTextFieldComponent.new(text: "John", label: "Full name"))
    assert_selector "dl dt.label", text: "Full name"
    assert_selector "dl dd", text: "John"
  end

  def test_renders_block_content_as_description_list_when_no_text
    render_inline(PrefilledTextFieldComponent.new(label: "Full name")) do
      "<p>John Doe</p>".html_safe
    end
    assert_selector "dl dt.label", text: "Full name"
    assert_selector "dl dd p", text: "John Doe"
  end

  def test_renders_label_as_heading_when_heading_given
    render_inline(PrefilledTextFieldComponent.new(label: "Full name", heading: :h3)) do
      "<p>John Doe</p>".html_safe
    end
    assert_selector "h3.label.block", text: "Full name"
  end

  def test_currency_variant_formats_with_dollar_sign_and_delimiter
    render_inline(PrefilledTextFieldComponent.new(text: 1234, label: "Amount", variant: :currency))
    assert_selector "dd", text: "$1,234"
  end

  def test_invalid_variant_raises
    assert_raises(ArgumentError) do
      PrefilledTextFieldComponent.new(text: "foo", label: "bar", variant: :invalid)
    end
  end

  def test_css_class_is_appended_to_root
    render_inline(PrefilledTextFieldComponent.new(text: "foo", label: "bar", css_class: "mt-cfa-lg"))
    # Without a heading: this renders as a <dl> description list (semantic default).
    assert_selector "dl.cfa-stack-sm.mt-cfa-lg"
  end
end
