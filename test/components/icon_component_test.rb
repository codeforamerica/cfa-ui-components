# frozen_string_literal: true

require "test_helper"

class IconComponentTest < ViewComponent::TestCase
  def test_renders_sprite_use_for_known_icon
    render_inline(IconComponent.new(icon: "info_outline"))
    assert_selector "svg[role='img'][aria-label='info outline icon']"
    assert_selector "svg use[href$='#info_outline']", visible: :all
  end

  def test_renders_nothing_for_unknown_icon
    render_inline(IconComponent.new(icon: "unknown"))
    assert_no_selector "svg[role='img']"
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
