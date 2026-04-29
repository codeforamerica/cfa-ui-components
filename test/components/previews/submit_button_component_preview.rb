class SubmitButtonComponentPreview < FormComponentPreview
  def default
    render(SubmitButtonComponent.new(form:))
  end

  def secondary
    render(SubmitButtonComponent.new(form:, style: :secondary))
  end

  def custom_label
    render(SubmitButtonComponent.new(form:, label: I18n.t("submit")))
  end

  def primary_disabled
    render(SubmitButtonComponent.new(form:, disabled: true))
  end

  def secondary_disabled
    render(SubmitButtonComponent.new(form:, style: :secondary, disabled: true))
  end
end
