class AlertComponentPreview < ViewComponent::Preview
  def default
    render(AlertComponent.new(title: "This is not legal advice")) do
      "If you're worried about how this could affect you, talk to a trusted attorney or advocate."
    end
  end

  def without_title
    render(AlertComponent.new) do
      "If you're worried about how this could affect you, talk to a trusted attorney or advocate."
    end
  end

  def dismissible
    render(AlertComponent.new(title: "This is not legal advice", dismissible: true)) do
      "If you're worried about how this could affect you, talk to a trusted attorney or advocate."
    end
  end
end
