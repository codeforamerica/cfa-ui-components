class PrefilledTextFieldComponentPreview < ViewComponent::Preview
  def text
    render PrefilledTextFieldComponent.new(label: "Your text") do
      content_tag(:p, "Some text") +
        content_tag(:p, "More text")
    end
  end

  def currency
    render(PrefilledTextFieldComponent.new(label: "Your refund", text: "1000", style: :currency))
  end
end
