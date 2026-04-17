# frozen_string_literal: true

require "test_helper"

class CardComponentTest < ViewComponent::TestCase
  def test_renders_content
    render_inline(CardComponent.new) { "Card body" }
    assert_text "Card body"
  end

  def test_has_border_class
    render_inline(CardComponent.new) { "Card body" }
    assert_selector "div.border"
  end

  def test_renders_with_label_slot
    render_inline(CardComponent.new) do |c|
      c.with_label { "<h2>Section title</h2>".html_safe }
      "Card body"
    end
    assert_selector "h2", text: "Section title"
    assert_text "Card body"
  end
end
