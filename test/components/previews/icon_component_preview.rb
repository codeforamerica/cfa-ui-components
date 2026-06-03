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

  def warn
    render(IconComponent.new(icon: "warn"))
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

  def circle_check_filled
    render(IconComponent.new(icon: "circle_check_filled"))
  end

  def check
    render(IconComponent.new(icon: "check"))
  end

  def error
    render(IconComponent.new(icon: "error"))
  end

  def loading
    render(IconComponent.new(icon: "loading"))
  end

  def cancel_circle
    render(IconComponent.new(icon: "cancel_circle"))
  end

  def external_link
    render(IconComponent.new(icon: "external_link"))
  end

  def download
    render(IconComponent.new(icon: "download"))
  end
  # @!endgroup
end
