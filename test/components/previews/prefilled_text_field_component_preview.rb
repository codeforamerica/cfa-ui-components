class PrefilledTextFieldComponentPreview < ViewComponent::Preview
  def text
    render PrefilledTextFieldComponent.new(label: "Your text") do
      content_tag(:p, "Some text") +
        content_tag(:p, "More text")
    end
  end

  def heading
    render PrefilledTextFieldComponent.new(label: "Your text", heading: :h3) do
      content_tag(:p, "Some text") +
        content_tag(:p, "More text")
    end
  end

  def currency
    render(PrefilledTextFieldComponent.new(label: "Your refund", text: "1000", variant: :currency))
  end
end
