class TextComponentPreview < ViewComponent::Preview
  def default
    render(TextComponent.new(text: I18n.t("continue")))
  end

  def with_icon
    render(TextComponent.new(text: I18n.t("continue"), icon: "x_mark"))
  end
end
