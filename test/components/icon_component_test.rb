# frozen_string_literal: true

require "test_helper"

class IconComponentTest < ViewComponent::TestCase
  def test_renders_image_for_known_icon
    render_inline(IconComponent.new(icon: "info"))
    assert_selector "span[role='img'][aria-label='info icon']"
  end

  def test_renders_nothing_for_unknown_icon
    render_inline(IconComponent.new(icon: "unknown"))
    assert_no_selector "span[role='img']"
  end
end
