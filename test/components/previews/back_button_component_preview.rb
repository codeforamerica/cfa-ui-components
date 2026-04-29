class BackButtonComponentPreview < ViewComponent::Preview
  # @!group Back
  def default
    render(BackButtonComponent.new(back_url: "/"))
  end

  def disabled
    render(BackButtonComponent.new(back_url: "/", disabled: true))
  end
  # @!endgroup
end
