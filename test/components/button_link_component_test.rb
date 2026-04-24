# frozen_string_literal: true

require "test_helper"

class ButtonLinkComponentTest < ViewComponent::TestCase
  def test_renders_link_with_label_and_url_for_get
    render_inline(ButtonLinkComponent.new(label: "Go", url: "/next"))
    assert_selector "a[href='/next']", text: "Go"
  end

  def test_primary_variant_is_default
    render_inline(ButtonLinkComponent.new(label: "Go", url: "/next"))
    assert_selector "a.btn--primary"
  end

  def test_secondary_variant
    render_inline(ButtonLinkComponent.new(label: "Go", url: "/next", variant: :secondary))
    assert_selector "a.btn--secondary"
  end

  def test_destructive_variant
    render_inline(ButtonLinkComponent.new(label: "Delete", url: "/delete", variant: :destructive))
    assert_selector "button.btn--destructive", text: "Delete"
  end

  def test_small_size
    render_inline(ButtonLinkComponent.new(label: "Go", url: "/next", size: :small))
    assert_selector "a.btn--small"
  end

  def test_invalid_variant_raises
    assert_raises(ArgumentError) do
      ButtonLinkComponent.new(label: "Go", url: "/next", variant: :invalid)
    end
  end

  def test_invalid_size_raises
    assert_raises(ArgumentError) do
      ButtonLinkComponent.new(label: "Go", url: "/next", size: :invalid)
    end
  end

  def test_turbo_false_disables_turbo
    render_inline(ButtonLinkComponent.new(label: "Go", url: "/next", turbo: false))
    assert_selector "a[data-turbo='false']"
  end

  def test_post_renders_button
    render_inline(ButtonLinkComponent.new(label: "Delete", url: "/delete", method: :post))
    assert_selector "button", text: "Delete"
  end

  def test_destructive_variant_method_can_be_overridden
    render_inline(ButtonLinkComponent.new(label: "Remove", url: "#", variant: :destructive, method: :get))
    assert_selector "a.btn--destructive[href='#']", text: "Remove"
  end

  def test_destructive_variant_icon_can_be_overridden
    render_inline(ButtonLinkComponent.new(label: "Remove", url: "/delete", variant: :destructive, icon: "close"))
    assert_no_selector ".usa-icon use[href*='#delete']"
  end
end
