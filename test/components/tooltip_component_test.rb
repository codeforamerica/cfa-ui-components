# frozen_string_literal: true

require "test_helper"

class TooltipComponentTest < ViewComponent::TestCase
  def test_renders_label
    render_inline(TooltipComponent.new(label: "Learn more", modal_name: "info"))
    assert_text "Learn more"
  end

  def test_renders_as_button
    render_inline(TooltipComponent.new(label: "Learn more", modal_name: "info"))
    assert_selector "button[type='button']"
  end

  def test_renders_info_icon
    render_inline(TooltipComponent.new(label: "Learn more", modal_name: "info"))
    assert_selector "img[alt='']"
  end

  def test_has_alpine_data_attribute
    render_inline(TooltipComponent.new(label: "Learn more", modal_name: "info"))
    assert_selector "button[x-data]"
  end

  def test_dispatches_correct_modal_event
    render_inline(TooltipComponent.new(label: "Learn more", modal_name: "info"))
    assert_includes rendered_content, "$dispatch('info-modal')"
  end
end
