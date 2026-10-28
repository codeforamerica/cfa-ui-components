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

  def test_renders_info_icon_by_default
    render_inline(AlertComponent.new) { "Heads up" }
    assert_selector "svg.cfa-icon.text-icon-default[aria-hidden='true']", visible: :all
    assert_selector "svg.cfa-icon path[d='M12 16V12']", visible: :all
  end

  def test_renders_warning_icon_for_warning_variant
    render_inline(AlertComponent.new(variant: :warning)) { "Heads up" }
    assert_selector "svg.cfa-icon path[d='M0.875 0.875V4.875']", visible: :all
  end

  def test_icon_paths_stay_unfilled_under_cfa_icon_fill
    %i[info warning].each do |variant|
      render_inline(AlertComponent.new(variant:)) { "Heads up" }
      assert_selector "svg.cfa-icon path", visible: :all, count: 3
      assert_no_selector "svg.cfa-icon path:not([fill='none'])", visible: :all
    end
  end

  def test_omits_dismiss_button_by_default
    render_inline(AlertComponent.new) { "Heads up" }
    assert_no_selector "button"
  end

  def test_renders_dismiss_button_when_dismissible
    render_inline(AlertComponent.new(dismissible: true)) { "Heads up" }
    assert_selector "button[aria-label='Dismiss alert']"
  end

  def test_omits_actions_when_none_given
    render_inline(AlertComponent.new) { "Heads up" }
    assert_no_selector ".cfa-alert__actions"
  end

  def test_renders_link_action_when_url_given
    render_inline(AlertComponent.new) do |alert|
      alert.with_action(label: "Learn more", url: "/learn")
      "Heads up"
    end
    assert_selector ".cfa-alert__actions a.cfa-alert__action[href='/learn']", text: "Learn more"
  end

  def test_renders_button_action_without_url
    render_inline(AlertComponent.new) do |alert|
      alert.with_action(label: "Retry", class: "extra", data: {action: "retry"})
      "Heads up"
    end
    assert_selector "button.cfa-alert__action.extra[type='button'][data-action='retry']", text: "Retry"
  end

  def test_renders_multiple_actions_alongside_dismiss
    render_inline(AlertComponent.new(dismissible: true)) do |alert|
      alert.with_action(label: "One")
      alert.with_action(label: "Two")
      "Heads up"
    end
    assert_selector ".cfa-alert__action", count: 2
    assert_selector "button[aria-label='Dismiss alert']"
  end

  def test_css_class_is_appended_without_dropping_base_classes
    render_inline(AlertComponent.new(css_class: "mt-cfa-sm")) { "Heads up" }
    assert_selector "div.cfa-alert.mt-cfa-sm.bg-background-tertiary.border-border-secondary"
  end

  def test_raises_for_invalid_variant
    assert_raises(ArgumentError) { AlertComponent.new(variant: :bogus) }
  end
end
