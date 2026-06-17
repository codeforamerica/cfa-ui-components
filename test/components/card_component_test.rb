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

  def test_informational_variant_renders_content
    render_inline(CardComponent.new(variant: :informational)) { "Info body" }
    assert_text "Info body"
    assert_selector "div.rounded-lg"
    assert_no_selector "div.border"
  end

  def test_css_class_is_appended_to_default_variant
    render_inline(CardComponent.new(css_class: "-mt-cfa-med")) { "Card body" }
    assert_selector "div.cfa-card.-mt-cfa-med.border"
  end

  def test_css_class_is_appended_to_informational_variant
    render_inline(CardComponent.new(variant: :informational, css_class: "-mt-cfa-med")) { "Info body" }
    assert_selector "div.cfa-card.-mt-cfa-med.bg-background-container"
  end

  def test_css_class_is_appended_to_action_variant
    render_inline(CardComponent.new(css_class: "-mt-cfa-med")) do |c|
      c.with_button { "Go" }
      "Card body"
    end
    assert_selector "article.cfa-card.-mt-cfa-med.overflow-clip"
  end
end
