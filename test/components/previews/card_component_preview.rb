class CardComponentPreview < ViewComponent::Preview
  def default
    render(CardComponent.new) do
      content_tag(:p, content_tag(:strong, "Sample form card")) +
        content_tag(:p, "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Ut volutpat ornare elit a vestibulum. Etiam eget sodales ipsum. Etiam accumsan neque erat.", class: "m-0")
    end
  end

  def with_label
    render(CardComponent.new) do |c|
      c.with_label { content_tag(:h2, "Sample form card") }
      content_tag(:p, "Lorem ipsum dolor sit amet, consectetur adipiscing elit.", class: "m-0") +
        content_tag(:p, "Ut volutpat ornare elit a vestibulum.", class: "m-0")
    end
  end
end
