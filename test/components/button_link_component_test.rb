# frozen_string_literal: true

require "test_helper"

class ButtonLinkComponentTest < ViewComponent::TestCase
  def test_renders_link_with_label_and_url_for_get
    render_inline(ButtonLinkComponent.new(label: "Go", url: "/next"))
    assert_selector "a[href='/next']", text: "Go"
  end

  def test_primary_style_is_default
    render_inline(ButtonLinkComponent.new(label: "Go", url: "/next"))
    assert_selector "a.btn--primary"
  end

  def test_secondary_style
    render_inline(ButtonLinkComponent.new(label: "Go", url: "/next", style: :secondary))
    assert_selector "a.btn--secondary"
  end

  def test_destructive_style
    render_inline(ButtonLinkComponent.new(label: "Delete", url: "/delete", style: :destructive))
    assert_selector "a.btn--destructive"
  end

  def test_small_size
    render_inline(ButtonLinkComponent.new(label: "Go", url: "/next", size: :small))
    assert_selector "a.btn--small"
  end

  def test_invalid_style_raises
    assert_raises(ArgumentError) do
      ButtonLinkComponent.new(label: "Go", url: "/next", style: :invalid)
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
end
