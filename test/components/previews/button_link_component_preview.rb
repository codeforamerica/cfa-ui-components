class ButtonLinkComponentPreview < ViewComponent::Preview
  def primary
    render(ButtonLinkComponent.new(label: I18n.t("continue"), url: "https://www.google.com", turbo: false))
  end

  def secondary
    render(ButtonLinkComponent.new(label: I18n.t("decline"), url: "/decline", style: :secondary))
  end

  def destructive
    render(ButtonLinkComponent.new(label: I18n.t("remove"), url: "/destroy", style: :destructive, method: :post))
  end
end
