class LinkComponentPreview < ViewComponent::Preview
  # @!group Default
  # Use a random fragment so the browser never reports the link as visited,
  # guaranteeing the unvisited styling renders.
  def default
    render(LinkComponent.new(label: I18n.t("continue"), url: "##{SecureRandom.hex(8)}"))
  end

  def with_icon
    render(LinkComponent.new(label: I18n.t("continue"), url: "##{SecureRandom.hex(8)}", icon: true))
  end
  # @!endgroup

  # @!group Visited
  # Links to the current page (`#`) are reported as visited by the browser,
  # so these previews show the visited styling without relying on history.
  def visited
    render(LinkComponent.new(label: I18n.t("continue"), url: "#"))
  end

  def visited_with_icon
    render(LinkComponent.new(label: I18n.t("continue"), url: "#", icon: true))
  end
  # @!endgroup
end
