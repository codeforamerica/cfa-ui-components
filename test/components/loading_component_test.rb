# frozen_string_literal: true

require "test_helper"

class LoadingComponentTest < ViewComponent::TestCase
  def test_renders_loading_container
    render_inline(LoadingComponent.new)
    assert_selector "div.loading-container"
  end

  def test_renders_loading_image
    render_inline(LoadingComponent.new)
    assert_selector "div.loading-container img[alt='']"
  end
end
