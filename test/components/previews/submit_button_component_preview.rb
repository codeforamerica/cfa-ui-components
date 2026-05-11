class SubmitButtonComponentPreview < FormComponentPreview
  # @!group Primary
  def default
    render(SubmitButtonComponent.new(form:))
  end

  def primary_disabled
    render(SubmitButtonComponent.new(form:, disabled: true))
  end
  # @!endgroup

  # @!group Secondary
  def secondary
    render(SubmitButtonComponent.new(form:, style: :secondary))
  end

  def secondary_disabled
    render(SubmitButtonComponent.new(form:, style: :secondary, disabled: true))
  end
  # @!endgroup

  def custom_label
    render(SubmitButtonComponent.new(form:, label: I18n.t("submit")))
  end
end
