class InputComponentPreview < FormComponentPreview
  def default
    render(InputComponent.new(form: form, method: :first_name, label: I18n.t(:first_name)))
  end

  def with_help_text
    render(InputComponent.new(form: form, method: :first_name, label: I18n.t(:first_name), help_text: "Or preferred name"))
  end

  def required
    render(InputComponent.new(form: form, method: :first_name, label: I18n.t(:first_name), required: true))
  end

  def prefilled
    custom_model = TestModel.new(first_name: "Mike")
    render(InputComponent.new(form: form(model: custom_model), method: :first_name, label: I18n.t(:first_name)))
  end

  def with_error
    custom_model = TestModel.new
    custom_model.valid?
    render(InputComponent.new(form: form(model: custom_model), method: :first_name, label: I18n.t(:first_name)))
  end
end
