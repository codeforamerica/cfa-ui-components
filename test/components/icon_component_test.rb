# frozen_string_literal: true

require "test_helper"

class IconComponentTest < ViewComponent::TestCase
  def test_renders_sprite_use_for_known_icon
    render_inline(IconComponent.new(icon: "info_outline"))
    assert_selector "svg[role='img'][aria-label='info outline icon']"
    assert_selector "svg use[href$='#info_outline']", visible: :all
  end

  def test_raises_for_unknown_icon
    error = assert_raises(ArgumentError) do
      render_inline(IconComponent.new(icon: "unknown"))
    end
    assert_match(/Unknown icon "unknown"/, error.message)
  end

  def test_defaults_to_icon_default_color
    render_inline(IconComponent.new(icon: "info_outline"))
    assert_selector "svg.cfa-icon.text-icon-default", visible: :all
  end

  def test_color_can_be_overridden
    render_inline(IconComponent.new(icon: "info_outline", css_class: "text-error"))
    assert_selector "svg.cfa-icon.text-error", visible: :all
    assert_no_selector "svg.text-icon-default", visible: :all
  end

  def test_loading_renders_masked_span
    render_inline(IconComponent.new(icon: "loading"))
    assert_selector "span.cfa-icon-mask[role='img'][aria-label='loading icon']", visible: :all
  end

  def test_clock_renders_masked_span
    render_inline(IconComponent.new(icon: "clock"))
    assert_selector "span.cfa-icon-mask[role='img'][aria-label='clock icon']", visible: :all
  end
end
