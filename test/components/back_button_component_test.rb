# frozen_string_literal: true

require "test_helper"

class BackButtonComponentTest < ViewComponent::TestCase
  def test_renders_link_to_back_url
    render_inline(BackButtonComponent.new(back_url: "/previous"))
    assert_selector "a[href='/previous']"
  end

  def test_renders_back_text
    render_inline(BackButtonComponent.new(back_url: "/previous"))
    assert_selector "a", text: /back/i
  end
end
