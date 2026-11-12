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

  def page_banner
    render(AlertComponent.new(title: "SimpleFile is closing soon", dismissible: true, role: :region)) do
      "There's still time to file."
    end
  end

  def with_action
    render(AlertComponent.new(title: "This is the title")) do |alert|
      alert.with_action(label: "Button", url: "#")
      "This is the content. Go for it!"
    end
  end

  def with_action_without_title
    render(AlertComponent.new(variant: :warning)) do |alert|
      alert.with_action(label: "Button", url: "#")
      "This content is very very very very very very very very very very very very very very very very " \
        "very very very very very very very long to show how the icon lines up with the first line."
    end
  end

  def with_action_dismissible
    render(AlertComponent.new(title: "This is the title", dismissible: true)) do |alert|
      alert.with_action(label: "Button")
      "This is the content. Go for it!"
    end
  end

  def warning
    render(AlertComponent.new(variant: :warning, title: "This is not legal advice")) do
      "If you're worried about how this could affect you, talk to a trusted attorney or advocate."
    end
  end
end
