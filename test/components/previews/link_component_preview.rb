class LinkComponentPreview < ViewComponent::Preview
  def default
    render(LinkComponent.new(label: I18n.t("continue"), url: "/continue"))
  end

  def with_icon
    render(LinkComponent.new(label: I18n.t("continue"), url: "/continue", icon: true))
  end
end
