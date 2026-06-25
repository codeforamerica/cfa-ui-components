class LinkComponentPreview < ViewComponent::Preview
  # Browsers apply `:visited` based on history, which makes previews unstable.
  # Force the desired colors via `!` utilities so each variant renders consistently.
  UNVISITED_CLASSES = "text-link-unvisited! border-link-unvisited!".freeze
  VISITED_CLASSES = "text-link-visited! border-link-visited!".freeze

  # @!group Default
  def default
    render(LinkComponent.new(label: "Continue to IRS.gov", url: "/inspect/link/default", sr_label: "Opens in a new tab", external_sr_label: "External, opens in a new tab", html_attrs: {class: UNVISITED_CLASSES}))
  end

  def with_icon
    render(LinkComponent.new(label: "Continue to IRS.gov", url: "https://www.irs.gov", sr_label: "Opens in a new tab", external_sr_label: "External, opens in a new tab", html_attrs: {class: UNVISITED_CLASSES}))
  end
  # @!endgroup

  # @!group Visited
  def visited
    render(LinkComponent.new(label: "Continue to IRS.gov", url: "/inspect/link/default", sr_label: "Opens in a new tab", external_sr_label: "External, opens in a new tab", html_attrs: {class: VISITED_CLASSES}))
  end

  def visited_with_icon
    render(LinkComponent.new(label: "Continue to IRS.gov", sr_label: "Opens in a new tab", external_sr_label: "External, opens in a new tab", url: "https://www.irs.gov", html_attrs: {class: VISITED_CLASSES}))
  end
  # @!endgroup
end
