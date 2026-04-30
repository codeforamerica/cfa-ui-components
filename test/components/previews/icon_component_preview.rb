class IconComponentPreview < ViewComponent::Preview
  # @!group Icons
  def info
    render(IconComponent.new(icon: "info"))
  end

  def question
    render(IconComponent.new(icon: "question"))
  end

  def circle_check
    render(IconComponent.new(icon: "circle_check"))
  end

  def circle_xmark
    render(IconComponent.new(icon: "circle_xmark"))
  end

  def xmark
    render(IconComponent.new(icon: "xmark"))
  end

  def alert
    render(IconComponent.new(icon: "alert"))
  end

  def delete
    render(IconComponent.new(icon: "delete"))
  end

  def arrow_left
    render(IconComponent.new(icon: "arrow_left"))
  end

  def chevron_down
    render(IconComponent.new(icon: "chevron_down"))
  end

  def chevron_up
    render(IconComponent.new(icon: "chevron_up"))
  end
  # @!endgroup
end
