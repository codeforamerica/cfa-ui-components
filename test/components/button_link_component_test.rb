# frozen_string_literal: true

require "test_helper"

class ButtonLinkComponentTest < ViewComponent::TestCase
  def test_renders_button_with_label_and_url
    render_inline(ButtonLinkComponent.new(label: "Go", url: "/next"))
    assert_selector "button", text: "Go"
  end

  def test_primary_style_is_default
    render_inline(ButtonLinkComponent.new(label: "Go", url: "/next"))
    assert_selector "button.btn--primary"
  end

  def test_secondary_style
    render_inline(ButtonLinkComponent.new(label: "Go", url: "/next", style: :secondary))
    assert_selector "button.btn--secondary"
  end

  def test_destructive_style
    render_inline(ButtonLinkComponent.new(label: "Delete", url: "/delete", style: :destructive))
    assert_selector "button.btn--destructive"
  end

  def test_small_size
    render_inline(ButtonLinkComponent.new(label: "Go", url: "/next", size: :small))
    assert_selector "button.btn--small"
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
    assert_selector "form[data-turbo='false']"
  end
end
