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
    # Decorative: the button's visible "Learn more" label carries the meaning,
    # so the icon is hidden from assistive tech rather than shape-named.
    assert_selector "svg use[href$='#info_outline']", visible: :all
    assert_selector "svg[aria-hidden='true']", visible: :all
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

    assert_selector "[role='dialog'][aria-modal='true']"
    assert_selector "ul li", text: "Item"
  end

  def test_modal_header_defaults_to_label
    render_inline(TooltipComponent.new(label: "Learn more", modal_name: "info")) do
      "Details."
    end
    assert_selector "h1", text: "Learn more"
  end

  def test_modal_header_can_be_overridden
    render_inline(TooltipComponent.new(label: "Learn more", modal_name: "info", header: "Custom header")) do
      "Body."
    end
    assert_selector "h1", text: "Custom header"
    assert_no_selector "h1", text: "Learn more"
  end

  def test_css_class_is_appended_without_dropping_base_classes
    render_inline(TooltipComponent.new(label: "Learn more", modal_name: "info", css_class: "-mt-cfa-med"))
    assert_selector "button.-mt-cfa-med.group.text-link-unvisited"
  end

  def test_no_css_class_leaves_base_classes_clean
    render_inline(TooltipComponent.new(label: "Learn more", modal_name: "info"))
    assert_selector "button.group.text-link-unvisited"
  end

  def test_analytics_id_defaults_to_modal_name
    render_inline(TooltipComponent.new(label: "Learn more", modal_name: "self_employment_income"))
    assert_selector "button[data-analytics-event='tooltip_clicked'][data-analytics-id='self_employment_income']"
  end

  def test_analytics_id_can_be_overridden
    render_inline(TooltipComponent.new(label: "Learn more", modal_name: "info", tooltip_id: "permanent_home"))
    assert_selector "button[data-analytics-event='tooltip_clicked'][data-analytics-id='permanent_home']"
  end
end
