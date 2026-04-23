class ButtonLinkComponentPreview < ViewComponent::Preview
  def primary
    render(ButtonLinkComponent.new(label: I18n.t("continue"), url: "https://www.google.com"))
  end

  def secondary
    render(ButtonLinkComponent.new(label: I18n.t("decline"), url: "/decline", variant: :secondary))
  end

  def destructive
    render(ButtonLinkComponent.new(label: I18n.t("remove"), url: "/destroy", variant: :destructive))
  end

  def primary_small
    render(ButtonLinkComponent.new(label: I18n.t("continue"), url: "https://www.google.com", size: :small))
  end

  def secondary_small
    render(ButtonLinkComponent.new(label: I18n.t("decline"), url: "/decline", variant: :secondary, size: :small))
  end

  def destructive_small
    render(ButtonLinkComponent.new(label: I18n.t("remove"), url: "/destroy", variant: :destructive, size: :small))
  end

  def primary_with_icon
    render(ButtonLinkComponent.new(label: I18n.t("continue"), url: "https://www.google.com", icon: "circle_check"))
  end

  def secondary_with_icon
    render(ButtonLinkComponent.new(label: I18n.t("decline"), url: "/decline", variant: :secondary, icon: "circle_xmark"))
  end

  def primary_small_with_icon
    render(ButtonLinkComponent.new(label: I18n.t("continue"), url: "https://www.google.com", size: :small, icon: "circle_check"))
  end

  def secondary_small_with_icon
    render(ButtonLinkComponent.new(label: I18n.t("decline"), url: "/decline", variant: :secondary, size: :small, icon: "circle_xmark"))
  end
end
