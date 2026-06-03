class IconComponentPreview < ViewComponent::Preview
  # @!group Icons
  def info_outline
    render(IconComponent.new(icon: "info_outline"))
  end

  def help_outline
    render(IconComponent.new(icon: "help_outline"))
  end

  def check_circle_outline
    render(IconComponent.new(icon: "check_circle_outline"))
  end

  def highlight_off
    render(IconComponent.new(icon: "highlight_off"))
  end

  def close
    render(IconComponent.new(icon: "close"))
  end

  def warning
    render(IconComponent.new(icon: "warning"))
  end

  def delete
    render(IconComponent.new(icon: "delete"))
  end

  def arrow_back
    render(IconComponent.new(icon: "arrow_back"))
  end

  def expand_more
    render(IconComponent.new(icon: "expand_more"))
  end

  def expand_less
    render(IconComponent.new(icon: "expand_less"))
  end

  def clock
    render(IconComponent.new(icon: "clock"))
  end

  def loading
    render(IconComponent.new(icon: "loading"))
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
