class StepIndicatorComponentPreview < ViewComponent::Preview
  # @!group Progress through a 5-section flow
  def step_one_example
    render(StepIndicatorComponent.new(current_step: 1, total_steps: 5, title: "Tell us about yourself"))
  end

  def step_two_example
    render(StepIndicatorComponent.new(current_step: 2, total_steps: 5, title: "Add your dependents"))
  end

  def step_three_example
    render(StepIndicatorComponent.new(current_step: 3, total_steps: 5, title: "Household income"))
  end

  def step_four_example
    render(StepIndicatorComponent.new(current_step: 4, total_steps: 5, title: "Review your answers"))
  end

  def step_five_example
    render(StepIndicatorComponent.new(current_step: 5, total_steps: 5, title: "Submit"))
  end
  # @!endgroup

  # @!group Flexible step counts
  def three_steps
    render(StepIndicatorComponent.new(current_step: 2, total_steps: 3, title: "Fewer sections still fill the full width"))
  end

  def eight_steps
    render(StepIndicatorComponent.new(current_step: 5, total_steps: 8, title: "More sections shrink to fit"))
  end
  # @!endgroup

  # @param current_step number
  # @param total_steps number
  # @param title text
  def playground(current_step: 2, total_steps: 4, title: "Add your dependents")
    render(StepIndicatorComponent.new(current_step:, total_steps:, title:))
  end
end
