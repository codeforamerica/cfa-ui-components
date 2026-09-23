# frozen_string_literal: true

require "test_helper"

class AlertComponentTest < ViewComponent::TestCase
  def test_renders_content
    render_inline(AlertComponent.new) { "Heads up" }
    assert_selector "div.cfa-alert", text: "Heads up"
  end

  def test_renders_title_when_present
    render_inline(AlertComponent.new(title: "This is not legal advice")) { "Talk to an advocate." }
    assert_selector "p.type-body-bold", text: "This is not legal advice"
  end

  def test_omits_title_when_absent
    render_inline(AlertComponent.new) { "Heads up" }
    assert_no_selector "p.type-body-bold"
  end

  def test_renders_warning_icon
    render_inline(AlertComponent.new) { "Heads up" }
    assert_selector "svg.cfa-icon.text-icon-default[aria-hidden='true']", visible: :all
  end

  def test_omits_dismiss_button_by_default
    render_inline(AlertComponent.new) { "Heads up" }
    assert_no_selector "button"
  end

  def test_renders_dismiss_button_when_dismissible
    render_inline(AlertComponent.new(dismissible: true)) { "Heads up" }
    assert_selector "button[aria-label='Dismiss alert']"
  end

  def test_css_class_is_appended_without_dropping_base_classes
    render_inline(AlertComponent.new(css_class: "mt-cfa-sm")) { "Heads up" }
    assert_selector "div.cfa-alert.mt-cfa-sm.bg-background-secondary"
  end

  def test_raises_for_invalid_variant
    assert_raises(ArgumentError) { AlertComponent.new(variant: :bogus) }
  end
end
