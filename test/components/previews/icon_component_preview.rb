class IconComponentPreview < ViewComponent::Preview
  def with_info
    render(IconComponent.new(icon: "info"))
  end

  def with_x_mark
    render(IconComponent.new(icon: "x_mark"))
  end

  def with_check_mark
    render(IconComponent.new(icon: "check_mark"))
  end
end
