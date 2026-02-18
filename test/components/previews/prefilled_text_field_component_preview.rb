class PrefilledTextFieldComponentPreview < ViewComponent::Preview
  def text
    render(PrefilledTextFieldComponent.new(label: "Your Text", text: "Primary Text"))
  end

  def numeric
    render(PrefilledTextFieldComponent.new(label: "Your Refund", text: "$1000", style: :numeric))
  end
end
