class BackButtonComponentPreview < ViewComponent::Preview
  def default
    render(BackButtonComponent.new(back_url: "/"))
  end

  def disabled
    render(BackButtonComponent.new(back_url: "/", disabled: true))
  end
end
