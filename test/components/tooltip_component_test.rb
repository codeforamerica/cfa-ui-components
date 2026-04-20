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
    assert_selector "img[alt='info icon']"
  end

  def test_has_alpine_data_attribute
    render_inline(TooltipComponent.new(label: "Learn more", modal_name: "info"))
    assert_selector "button[x-data]"
  end

  def test_dispatches_correct_modal_event
    render_inline(TooltipComponent.new(label: "Learn more", modal_name: "info"))
    assert_includes rendered_content, "$dispatch('info-modal')"
  end

  def test_does_not_render_modal_without_content
    render_inline(TooltipComponent.new(label: "Learn more", modal_name: "info"))
    assert_no_selector "dialog"
  end

  def test_renders_modal_with_block
    render_inline(TooltipComponent.new(label: "Learn more", modal_name: "info")) do
      "<ul><li>Item</li></ul>".html_safe
    end
    assert_selector "dialog"
    assert_selector "ul li", text: "Item"
  end

  def test_modal_header_defaults_to_label
    render_inline(TooltipComponent.new(label: "Learn more", modal_name: "info")) do
      "Details."
    end
    assert_selector "h2", text: "Learn more"
  end

  def test_modal_header_can_be_overridden
    render_inline(TooltipComponent.new(label: "Learn more", modal_name: "info", header: "Custom header")) do
      "Body."
    end
    assert_selector "h2", text: "Custom header"
    assert_no_selector "h2", text: "Learn more"
  end
end
