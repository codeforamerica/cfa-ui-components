class ButtonComponentPreview < ViewComponent::Preview
  # @!group Primary
  def primary
    render(ButtonComponent.new(label: I18n.t("cfaui.continue"), url: "https://www.google.com"))
  end

  def primary_small
    render(ButtonComponent.new(label: I18n.t("cfaui.continue"), url: "https://www.google.com", size: :small))
  end

  def primary_with_icon
    render(ButtonComponent.new(label: I18n.t("cfaui.continue"), url: "https://www.google.com", icon: "check_circle_outline"))
  end

  def primary_small_with_icon
    render(ButtonComponent.new(label: I18n.t("cfaui.continue"), url: "https://www.google.com", size: :small, icon: "check_circle_outline"))
  end

  def primary_disabled
    render(ButtonComponent.new(label: I18n.t("cfaui.continue"), url: "https://www.google.com", disabled: true))
  end
  # @!endgroup

  # @!group Secondary
  def secondary
    render(ButtonComponent.new(label: I18n.t("preview.decline"), url: "/decline", variant: :secondary))
  end

  def secondary_small
    render(ButtonComponent.new(label: I18n.t("preview.decline"), url: "/decline", variant: :secondary, size: :small))
  end

  def secondary_with_icon
    render(ButtonComponent.new(label: I18n.t("preview.decline"), url: "/decline", variant: :secondary, icon: "highlight_off"))
  end

  def secondary_small_with_icon
    render(ButtonComponent.new(label: I18n.t("preview.decline"), url: "/decline", variant: :secondary, size: :small, icon: "highlight_off"))
  end

  def secondary_disabled
    render(ButtonComponent.new(label: I18n.t("preview.decline"), url: "/decline", variant: :secondary, disabled: true))
  end
  # @!endgroup

  # @!group Destructive
  def destructive
    render(ButtonComponent.new(label: I18n.t("preview.remove"), url: "/destroy", variant: :destructive))
  end

  def destructive_small
    render(ButtonComponent.new(label: I18n.t("preview.remove"), url: "/destroy", variant: :destructive, size: :small))
  end

  def destructive_disabled
    render(ButtonComponent.new(label: I18n.t("preview.remove"), url: "/destroy", variant: :destructive, disabled: true))
  end
  # @!endgroup
end
