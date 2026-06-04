class InputComponentPreview < FormComponentPreview
  def default
    render(InputComponent.new(form:, method: :first_name, label: I18n.t(:first_name)))
  end

  def with_help_text
    render(InputComponent.new(form:, method: :first_name, label: I18n.t(:first_name), help_text: "Or preferred name"))
  end

  def optional
    render(InputComponent.new(form:, method: :first_name, label: I18n.t(:first_name), optional: true))
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

  # A long, wrapping error message: shows the icon top-aligned (items-start)
  # with the first line of text rather than centered against the block.
  def with_long_error
    custom_model = TestModel.new
    custom_model.errors.add(:first_name, "We couldn't find an account for that email address. Try with your phone number or get started here.")
    render(InputComponent.new(form: form(model: custom_model), method: :first_name, label: I18n.t(:first_name)))
  end
end
