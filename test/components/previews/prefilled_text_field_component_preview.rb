class PrefilledInputComponentPreview < ViewComponent::Preview
  def text
    render(PrefilledInputComponent.new(label: "Your text", text: "Primary text"))
  end

  def currency
    render(PrefilledInputComponent.new(label: "Your refund", text: "1000", style: :currency))
  end
end
