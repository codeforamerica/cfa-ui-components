class RevealComponentPreview < ViewComponent::Preview
  def default
    render(RevealComponent.new(summary_text: "I am summary")) do
      content_tag(:p, "Sample Details")
    end
  end

  def with_icon
    render(RevealComponent.new(summary_text: "I am summary", icon: "help_outline")) do
      content_tag(:p, "Sample form card")
    end
  end
end
