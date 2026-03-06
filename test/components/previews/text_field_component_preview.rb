class TextFieldComponentPreview < FormComponentPreview
  def default
    render(TextFieldComponent.new(form: form, method: :first_name, label: I18n.t(:first_name)))
  end

  def with_help_text
    render(TextFieldComponent.new(form: form, method: :first_name, label: I18n.t(:first_name), help_text: "Or preferred name"))
  end

  def required
    render(TextFieldComponent.new(form: form, method: :first_name, label: I18n.t(:first_name), required: true))
  end

  def prefilled
    custom_model = TestModel.new(first_name: "Mike")
    render(TextFieldComponent.new(form: form(model: custom_model), method: :first_name, label: I18n.t(:first_name)))
  end

  def with_error
    custom_model = TestModel.new
    custom_model.valid?
    render(TextFieldComponent.new(form: form(model: custom_model), method: :first_name, label: I18n.t(:first_name)))
  end
end
