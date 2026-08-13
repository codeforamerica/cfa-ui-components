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

  # Constrains the reveal to a narrow container so the summary stacks the
  # label above the chevron instead of letting it overflow the edge.
  def in_narrow_container
    content_tag(:div, style: "max-width: 18rem") do
      render(RevealComponent.new(summary_text: "A longer summary that would overflow a narrow card", icon: "info")) do
        content_tag(:p, "Sample details")
      end
    end
  end
end
