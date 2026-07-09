# frozen_string_literal: true

require "test_helper"

class StepIndicatorComponentTest < ViewComponent::TestCase
  def test_renders_one_segment_per_step
    render_inline(StepIndicatorComponent.new(current_step: 2, total_steps: 5, title: "Add your dependents"))
    assert_selector ".cfa-step-indicator [aria-hidden='true'] > span", count: 5
  end

  def test_fills_completed_and_current_sections
    render_inline(StepIndicatorComponent.new(current_step: 2, total_steps: 5, title: "Add your dependents"))
    assert_selector "span.bg-success", count: 2
    assert_selector "span.bg-border-secondary", count: 3
  end

  def test_segment_bar_is_decorative
    render_inline(StepIndicatorComponent.new(current_step: 2, total_steps: 5, title: "Add your dependents"))
    assert_selector "[aria-hidden='true'] > span", count: 5
    assert_no_selector "[role=progressbar]"
  end

  def test_renders_title
    render_inline(StepIndicatorComponent.new(current_step: 3, total_steps: 4, title: "Add your dependents"))
    assert_text "Add your dependents"
  end

  def test_always_shows_section_count
    render_inline(StepIndicatorComponent.new(current_step: 3, total_steps: 4, title: "Add your dependents"))
    assert_text "Section 3 of 4"
  end

  def test_prefixes_current_section_for_screen_readers
    render_inline(StepIndicatorComponent.new(current_step: 2, total_steps: 5, title: "Add your dependents"))
    assert_selector "span.sr-only", text: "Current section:"
  end

  def test_clamps_current_step_to_total
    render_inline(StepIndicatorComponent.new(current_step: 99, total_steps: 5, title: "Add your dependents"))
    assert_selector "span.bg-success", count: 5
    assert_text "Section 5 of 5"
  end

  def test_is_not_interactive
    render_inline(StepIndicatorComponent.new(current_step: 1, total_steps: 3, title: "Add your dependents"))
    assert_no_selector "a"
    assert_no_selector "button"
    assert_no_selector "input"
    assert_no_selector "[tabindex]"
  end

  def test_requires_positive_total_steps
    assert_raises(ArgumentError) { StepIndicatorComponent.new(current_step: 1, total_steps: 0, title: "Add your dependents") }
  end
end
