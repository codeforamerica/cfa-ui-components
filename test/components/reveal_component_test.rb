# frozen_string_literal: true

require "test_helper"

class RevealComponentTest < ViewComponent::TestCase
  def test_renders_summary_text
    render_inline(RevealComponent.new(summary_text: "More details"))
    assert_selector "summary", text: /More details/
  end

  def test_renders_content
    render_inline(RevealComponent.new(summary_text: "More details")) { "Hidden content" }
    assert_text "Hidden content"
  end

  def test_renders_icon_when_provided
    render_inline(RevealComponent.new(summary_text: "More details", icon: "info"))
    assert_selector "span[role='img'][aria-label='info icon']"
  end
end
