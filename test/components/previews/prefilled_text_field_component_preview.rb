class PrefilledTextFieldComponentPreview < ViewComponent::Preview
  def text
    render(PrefilledTextFieldComponent.new(label: "Your text", text: "Primary text"))
  end

  def currency
    render(PrefilledTextFieldComponent.new(label: "Your refund", text: "1000", style: :currency))
  end
end
