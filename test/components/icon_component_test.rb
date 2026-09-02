# frozen_string_literal: true

require "test_helper"

class IconComponentTest < ViewComponent::TestCase
  def test_renders_sprite_use_for_known_icon
    render_inline(IconComponent.new(icon: "info_outline"))
    assert_selector "svg use[href$='#info_outline']", visible: :all
  end

  def test_hides_the_icon_from_assistive_tech_by_default
    render_inline(IconComponent.new(icon: "info_outline"))
    assert_selector "svg[aria-hidden='true'][focusable='false']", visible: :all
    assert_no_selector "svg[role='img']", visible: :all
  end

  def test_unlabeled_icon_can_opt_back_into_a_humanized_name
    render_inline(IconComponent.new(icon: "info_outline", aria_hidden: false))
    assert_selector "svg[role='img'][aria-label='info outline icon']", visible: :all
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

  def test_label_overrides_the_default_accessible_name
    render_inline(IconComponent.new(icon: "check_circle", label: "Yes"))
    assert_selector "svg[role='img'][aria-label='Yes']", visible: :all
    assert_no_selector "svg[aria-label='check circle icon']", visible: :all
  end

  def test_label_overrides_the_default_accessible_name_on_file_based_icons
    render_inline(IconComponent.new(icon: "clock", label: "Pending"))
    assert_selector "svg.cfa-icon[role='img'][aria-label='Pending']", visible: :all
  end

  def test_aria_hidden_removes_the_icon_from_the_accessibility_tree
    render_inline(IconComponent.new(icon: "check_circle", aria_hidden: true))
    assert_selector "svg[aria-hidden='true'][focusable='false']", visible: :all
    assert_no_selector "svg[role='img']", visible: :all
  end

  def test_loading_renders_inline_svg
    render_inline(IconComponent.new(icon: "loading"))
    assert_selector "svg.cfa-icon[aria-hidden='true']", visible: :all
  end

  def test_clock_renders_inline_svg
    render_inline(IconComponent.new(icon: "clock"))
    assert_selector "svg.cfa-icon[aria-hidden='true']", visible: :all
  end

  def test_file_based_icon_uses_currentColor_fill
    render_inline(IconComponent.new(icon: "chevron"))
    assert_no_selector "span.cfa-icon-mask", visible: :all
    assert_selector "svg.cfa-icon path[fill='currentColor']", visible: :all
  end
end
