class RevealComponentPreview < ViewComponent::Preview
  def default
    render(RevealComponent.new(summary_text: "I am summary")) do
      content_tag(:p,  "Sample Details", style: "margin-top: 8px;")
    end
  end

  def with_icon
    render(RevealComponent.new(summary_text: "I am summary", icon: "question")) do
      content_tag(:p, "Sample form card", style: "margin-top: 8px;")
    end
  end

  def with_padding
    render(RevealComponent.new(summary_text: "I am summary", icon: "question")) do
      content_tag(:p, "Sample form card", style: "padding-top: 20px;")
    end
  end
end
