# frozen_string_literal: true

# Purely visual, non-interactive progress bar for multi-step flows.
#
# Renders `total_steps` equal-width segments; the first `current_step` of them
# are filled (completed + the current, in-progress section) and the remainder
# are shown as remaining. Progress is exposed to assistive technology via an
# ARIA `progressbar` that is named by its visible title (`aria-labelledby`).
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
    @title || I18n.t("cfaui.step_indicator.section", current: @current_step, total: @total_steps)
  end

  # Unique id so the progressbar can be labelled by its own visible title.
  def progressbar_title_id
    @progressbar_title_id ||= "cfa-step-indicator-title-#{SecureRandom.hex(4)}"
  end

  def filled?(index)
    index < @current_step
  end

  attr_reader :total_steps, :current_step
end
