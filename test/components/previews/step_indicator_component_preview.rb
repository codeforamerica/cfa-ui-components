class StepIndicatorComponentPreview < ViewComponent::Preview
  # @!group Progress through a 5-section flow
  def section_1_of_5
    render(StepIndicatorComponent.new(current_step: 1, total_steps: 5)) do
      "This is the content."
    end
  end

  def section_2_of_5
    render(StepIndicatorComponent.new(current_step: 2, total_steps: 5)) do
      "This is the content."
    end
  end

  def section_3_of_5
    render(StepIndicatorComponent.new(current_step: 3, total_steps: 5)) do
      "This is the content."
    end
  end

  def section_4_of_5
    render(StepIndicatorComponent.new(current_step: 4, total_steps: 5)) do
      "This is the content."
    end
  end

  def section_5_of_5
    render(StepIndicatorComponent.new(current_step: 5, total_steps: 5)) do
      "This is the content."
    end
  end
  # @!endgroup

  # @!group Flexible step counts
  def three_steps
    render(StepIndicatorComponent.new(current_step: 2, total_steps: 3)) do
      "Fewer sections still fill the full width."
    end
  end

  def eight_steps
    render(StepIndicatorComponent.new(current_step: 5, total_steps: 8)) do
      "More sections shrink to fit — no overflow or truncation."
    end
  end
  # @!endgroup

  # A custom heading overrides the default "Section X of Y" label.
  #
  # @param current_step number
  # @param total_steps number
  # @param title text
  def custom_title(current_step: 2, total_steps: 4, title: "Household details")
    render(StepIndicatorComponent.new(current_step:, total_steps:, title:)) do
      "Tell us who lives with you."
    end
  end
end
