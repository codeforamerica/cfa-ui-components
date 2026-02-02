class SubmitButtonComponentPreview < FormComponentPreview
  def default
    render(SubmitButtonComponent.new(form: form))
  end

  def secondary
    render(SubmitButtonComponent.new(form: form, style: :secondary))
  end

  def custom_label
    render(SubmitButtonComponent.new(form: form, label: I18n.t("submit")))
  end
end
