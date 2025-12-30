class ExpandableSectionComponentPreview < ViewComponent::Preview
  def default
    render(ExpandableSectionComponent.new(summary_text: "I am summary", detail_text: "I am detail"))
  end

  def with_icon
    render(ExpandableSectionComponent.new(summary_text: "I am summary", detail_text: "I am detail", icon: "question"))
  end
end
