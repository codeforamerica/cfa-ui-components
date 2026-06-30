# frozen_string_literal: true

require "test_helper"

class LinkComponentTest < ViewComponent::TestCase
  def test_renders_link_with_label_and_url
    render_inline(LinkComponent.new(label: "Visit us", url: "https://example.com", sr_label: "Opens in a new tab", external_sr_label: "External, opens in a new tab"))
    assert_selector "a[href='https://example.com']", text: "Visit us"
  end

  def test_opens_in_new_tab
    render_inline(LinkComponent.new(label: "Visit us", url: "https://example.com", sr_label: "Opens in a new tab", external_sr_label: "External, opens in a new tab"))
    assert_selector "a[target='_blank'][rel='noopener noreferrer']"
  end

  def test_renders_icon_when_provided
    render_inline(LinkComponent.new(label: "Visit us", url: "https://example.com", sr_label: "Opens in a new tab", external_sr_label: "External, opens in a new tab"))
    assert_selector "svg[role='img'][aria-label='launch icon']"
  end

  def test_internal_link_stays_in_same_tab
    render_inline(LinkComponent.new(label: "Sign in", url: "/accounts/sign-in", sr_label: "Sign in", external_sr_label: "External, opens in a new tab"))
    assert_no_selector "a[target='_blank']"
    assert_no_selector "svg[role='img']"
  end

  def test_external_override_forces_same_tab
    render_inline(LinkComponent.new(label: "Sign in", url: "https://example.com/sign-in", sr_label: "Sign in", external_sr_label: "External, opens in a new tab", external: false))
    assert_no_selector "a[target='_blank']"
    assert_no_selector "svg[role='img']"
  end
end
