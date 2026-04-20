class CardComponentPreview < ViewComponent::Preview
  def default
    render(CardComponent.new) do
      content_tag(:p, content_tag(:strong, "Sample form card")) +
        content_tag(:p, "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Ut volutpat ornare elit a vestibulum. Etiam eget sodales ipsum. Etiam accumsan neque erat.", class: "m-0")
    end
  end

  def secondary
    render(CardComponent.new(style: :secondary)) do
      content_tag(:p, content_tag(:strong, "Sample form card")) +
        content_tag(:p, "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Ut volutpat ornare elit a vestibulum. Etiam eget sodales ipsum. Etiam accumsan neque erat.", class: "m-0")
    end
  end
end
