# frozen_string_literal: true

# Purely visual, non-interactive progress bar for multi-step flows. Renders
# `total_steps` equal-width segments with the first `current_step` filled. The
# ARIA progressbar announces "Step N of M" via aria-valuetext (rather than a
# meaningless percentage) and is named "Current step[: title]".
class StepIndicatorComponent < ViewComponent::Base
  def initialize(current_step:, total_steps:, title: nil, css_class: nil)
    unless total_steps.to_i.positive?
      raise ArgumentError, "total_steps must be a positive integer"
    end

    @total_steps = total_steps.to_i
    # Clamp defensively so a flow that overshoots (or reports 0) still renders.
    @current_step = current_step.to_i.clamp(0, @total_steps)
    @title = title
    @css_class = css_class
  end

  def title
    @title.presence || step_label
  end

  def step_label
    I18n.t("cfaui.step_indicator.step", current: @current_step, total: @total_steps)
  end

  def accessible_name
    label = I18n.t("cfaui.step_indicator.current_step")
    @title.present? ? "#{label}: #{@title}" : label
  end

  def filled?(index)
    index < @current_step
  end

  attr_reader :total_steps, :current_step
end
