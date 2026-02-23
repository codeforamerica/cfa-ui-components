class PrefilledTextFieldComponentPreview < ViewComponent::Preview
  def text
    render(PrefilledTextFieldComponent.new(label: "Your text", text: "Primary text"))
  end

  def numeric
    render(PrefilledTextFieldComponent.new(label: "Your refund", text: "1000", style: :numeric))
  end
end
