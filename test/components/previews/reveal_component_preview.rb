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

  # Places reveals in a three-column card grid (like the gyraffe landing page)
  # so each card is narrow enough that the summary stacks the label above the
  # chevron instead of letting it overflow the edge.
  #
  # Template-backed (see in_narrow_container.html.erb): a preview's `render`
  # returns a descriptor Hash, not HTML, so it can't be wrapped in a
  # `content_tag`. The wrapping div lives in the ERB template instead.
  def in_narrow_container
  end
end
