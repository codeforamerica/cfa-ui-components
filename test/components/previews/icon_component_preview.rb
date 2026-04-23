class IconComponentPreview < ViewComponent::Preview
  def info
    render(IconComponent.new(icon: "info"))
  end

  def question
    render(IconComponent.new(icon: "question"))
  end

  def circle_xmark
    render(IconComponent.new(icon: "circle_xmark"))
  end

  def circle_check
    render(IconComponent.new(icon: "circle_check"))
  end
end
