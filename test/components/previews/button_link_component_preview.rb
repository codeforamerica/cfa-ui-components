class ButtonLinkComponentPreview < ViewComponent::Preview
  def primary
    render(ButtonLinkComponent.new(label: I18n.t("continue"), url: "https://www.google.com"))
  end

  def secondary
    render(ButtonLinkComponent.new(label: I18n.t("decline"), url: "/decline", style: :secondary))
  end

  def destructive
    render(ButtonLinkComponent.new(label: I18n.t("remove"), url: "/destroy", style: :destructive, method: :post))
  end
  def primary_small
    render(ButtonLinkComponent.new(label: I18n.t("continue"), url: "https://www.google.com", size: :small))
  end

  def secondary_small
    render(ButtonLinkComponent.new(label: I18n.t("decline"), url: "/decline", style: :secondary, size: :small))
  end

  def destructive_small
    render(ButtonLinkComponent.new(label: I18n.t("remove"), url: "/destroy", style: :destructive, method: :post, size: :small))
  end
end
