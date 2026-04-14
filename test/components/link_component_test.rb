# frozen_string_literal: true

require "test_helper"

class LinkComponentTest < ViewComponent::TestCase
  def test_renders_link_with_label_and_url
    render_inline(LinkComponent.new(label: "Visit us", url: "https://example.com"))
    assert_selector "a[href='https://example.com']", text: "Visit us"
  end

  def test_opens_in_new_tab
    render_inline(LinkComponent.new(label: "Visit us", url: "https://example.com"))
    assert_selector "a[target='_blank'][rel='noopener noreferrer']"
  end

  def test_renders_icon_when_provided
    render_inline(LinkComponent.new(label: "Visit us", url: "https://example.com", icon: "info"))
    assert_selector "img[alt='info icon']"
  end
end
