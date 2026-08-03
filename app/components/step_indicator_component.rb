# frozen_string_literal: true

# Purely visual, non-interactive progress bar for multi-step flows. Renders
# `total_steps` equal-width segments with the first `current_step` filled. The
# segment bar is decorative (aria-hidden); progress is conveyed to screen
# readers as text — a "Current section:" prefix, the section title, and a
# "Section N of M" count.
class StepIndicatorComponent < ViewComponent::Base
  def initialize(current_step:, total_steps:, title:, css_class: nil)
    unless total_steps.to_i.positive?
      raise ArgumentError, "total_steps must be a positive integer"
    end

    @total_steps = total_steps.to_i
    # Clamp defensively so a flow that overshoots (or reports 0) still renders.
    @current_step = current_step.to_i.clamp(0, @total_steps)
    @title = title
    @css_class = css_class
  end

  def section_label
    I18n.t("cfaui.step_indicator.section", current: @current_step, total: @total_steps)
  end

  def filled?(index)
    index < @current_step
  end

  attr_reader :total_steps, :current_step, :title
end
