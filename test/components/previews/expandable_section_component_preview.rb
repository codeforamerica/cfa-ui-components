class ExpandableSectionComponentPreview < ViewComponent::Preview
  def default
    render(ExpandableSectionComponent.new(summary_text: "I am summary")) do
      content_tag(:p,  "Sample Details")
    end
  end

  def with_icon
    render(ExpandableSectionComponent.new(summary_text: "I am summary", icon: "question")) do
      content_tag(:p, "Sample form card")
    end
  end
end
