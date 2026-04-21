class CardComponentPreview < ViewComponent::Preview
  def default
    render(CardComponent.new) do
      content_tag(:p, content_tag(:strong, "Sample form card")) +
        content_tag(:p, "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Ut volutpat ornare elit a vestibulum. Etiam eget sodales ipsum. Etiam accumsan neque erat.", class: "m-0")
    end
  end

  def with_heading
    render(CardComponent.new) do
      content_tag(:h2, "Sample form card") +
        content_tag(:p, "Lorem ipsum dolor sit amet, consectetur adipiscing elit.", class: "m-0") +
        content_tag(:p, "Ut volutpat ornare elit a vestibulum.", class: "m-0")
    end
  end

  def with_interspersed_headings
    render(CardComponent.new) do
      content_tag(:h3, "Name") +
        content_tag(:p, "Text field 1", class: "m-0") +
        content_tag(:p, "Text field 2", class: "m-0") +
        content_tag(:h3, "Date of birth") +
        content_tag(:p, "Date picker", class: "m-0") +
        content_tag(:h3, "Social security") +
        content_tag(:p, "TIN field", class: "m-0")
    end
  end
end
