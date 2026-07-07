# frozen_string_literal: true

require "test_helper"

class StepIndicatorComponentTest < ViewComponent::TestCase
  def test_renders_one_segment_per_step
    render_inline(StepIndicatorComponent.new(current_step: 2, total_steps: 5))
    assert_selector ".cfa-step-indicator [role=progressbar] > span", count: 5
  end

  def test_fills_completed_and_current_sections
    render_inline(StepIndicatorComponent.new(current_step: 2, total_steps: 5))
    assert_selector "span.bg-success", count: 2
    assert_selector "span.bg-border-secondary", count: 3
  end

  def test_exposes_progress_to_assistive_tech
    render_inline(StepIndicatorComponent.new(current_step: 2, total_steps: 5))
    assert_selector "[role=progressbar][aria-valuemin='0'][aria-valuemax='5'][aria-valuenow='2']"
    assert_selector "[role=progressbar][aria-valuetext='Step 2 of 5']"
  end

  def test_unnamed_progressbar_is_named_current_step
    render_inline(StepIndicatorComponent.new(current_step: 2, total_steps: 5))
    assert_selector "[role=progressbar][aria-label='Current step']"
  end

  def test_renders_default_step_label
    render_inline(StepIndicatorComponent.new(current_step: 3, total_steps: 4))
    assert_text "Step 3 of 4"
  end

  def test_custom_title_names_the_progressbar
    render_inline(StepIndicatorComponent.new(current_step: 1, total_steps: 3, title: "Getting started"))
    assert_text "Getting started"
    assert_selector "[role=progressbar][aria-label='Current step: Getting started']"
    assert_selector "[role=progressbar][aria-valuetext='Step 1 of 3']"
  end

  def test_renders_optional_content
    render_inline(StepIndicatorComponent.new(current_step: 1, total_steps: 3)) { "Tell us about yourself" }
    assert_text "Tell us about yourself"
  end

  def test_clamps_current_step_to_total
    render_inline(StepIndicatorComponent.new(current_step: 99, total_steps: 5))
    assert_selector "span.bg-success", count: 5
    assert_selector "[role=progressbar][aria-valuenow='5']"
  end

  def test_is_not_interactive
    render_inline(StepIndicatorComponent.new(current_step: 1, total_steps: 3)) { "content" }
    assert_no_selector "a"
    assert_no_selector "button"
    assert_no_selector "input"
    assert_no_selector "[tabindex]"
  end

  def test_requires_positive_total_steps
    assert_raises(ArgumentError) { StepIndicatorComponent.new(current_step: 1, total_steps: 0) }
  end
end
