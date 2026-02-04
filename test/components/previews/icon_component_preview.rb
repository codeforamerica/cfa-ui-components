class IconComponentPreview < ViewComponent::Preview
  def with_info
    render(IconComponent.new(icon: "info"))
  end

  def with_circle_xmark
    render(IconComponent.new(icon: "circle_xmark"))
  end

  def with_circle_check
    render(IconComponent.new(icon: "circle_check"))
  end
end
