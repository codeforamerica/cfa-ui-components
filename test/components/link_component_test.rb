# frozen_string_literal: true

require "test_helper"

class LinkComponentTest < ViewComponent::TestCase
  def test_renders_link_with_label_and_url
    render_inline(LinkComponent.new(label: "Visit us", url: "https://example.com", sr_label: "Opens in a new tab", external_sr_label: "External, opens in a new tab"))
    assert_selector "a[href='https://example.com']", text: "Visit us"
  end

  def test_external_link_opens_in_new_tab_with_icon
    render_inline(LinkComponent.new(label: "Visit us", url: "https://example.com", sr_label: "Opens in a new tab", external_sr_label: "External, opens in a new tab"))
    assert_selector "a[target='_blank'][rel='noopener noreferrer']"
    assert_selector "svg[role='img'][aria-label='launch icon']"
    assert_selector "span.sr-only", text: "External, opens in a new tab"
  end

  def test_internal_link_opens_in_new_tab_without_icon
    render_inline(LinkComponent.new(label: "Privacy", url: "/privacy", sr_label: "Opens in a new tab", external_sr_label: "External, opens in a new tab"))
    assert_selector "a[target='_blank'][rel='noopener noreferrer']"
    assert_no_selector "svg[role='img']"
    assert_selector "span.sr-only", text: "Opens in a new tab"
  end

  def test_new_tab_false_stays_in_same_tab_with_no_announcement
    render_inline(LinkComponent.new(label: "Sign in", url: "/accounts/sign-in", sr_label: "Opens in a new tab", external_sr_label: "External, opens in a new tab", new_tab: false))
    assert_no_selector "a[target='_blank']"
    assert_no_selector "svg[role='img']"
    assert_no_selector "span.sr-only"
  end

  def test_external_override_suppresses_icon_for_absolute_url
    # Consuming apps pass `external: false` for absolute links back to their own
    # host so they don't get the external affordance.
    render_inline(LinkComponent.new(label: "Sign in", url: "https://app.example.com/accounts/sign-in", sr_label: "Opens in a new tab", external_sr_label: "External, opens in a new tab", external: false))
    assert_selector "a[target='_blank']"
    assert_no_selector "svg[role='img']"
    assert_selector "span.sr-only", text: "Opens in a new tab"
  end
end
