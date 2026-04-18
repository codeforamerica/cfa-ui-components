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

  def test_has_cfa_card_class
    render_inline(CardComponent.new) { "Card body" }
    assert_selector "div.cfa-card"
  end
end
