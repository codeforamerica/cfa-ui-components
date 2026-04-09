# frozen_string_literal: true

require "test_helper"

class IconComponentTest < ViewComponent::TestCase
  def test_renders_image_for_known_icon
    render_inline(IconComponent.new(icon: "info"))
    assert_selector "img[alt='info icon']"
  end

  def test_renders_empty_alt_for_unknown_icon
    render_inline(IconComponent.new(icon: "unknown"))
    assert_selector "img[alt='']"
  end
end
