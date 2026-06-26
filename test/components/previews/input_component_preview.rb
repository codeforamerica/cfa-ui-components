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

  # A long, wrapping error message: shows the icon top-aligned with the first
  # line of text. Single-line messages (see with_error) center the icon instead.
  def with_long_error
    custom_model = TestModel.new
    custom_model.errors.add(:base, "We couldn't find an account for that email address. Try with your phone number or get started here.")
    render(InputComponent.new(form: form(model: custom_model), method: :base, label: I18n.t(:email)))
  end

  def obfuscate_first_entry
    render(InputComponent.new(form:, method: :state_id_number, label: "ID number", obfuscate: true, input_attrs: {autocomplete: "off"}))
  end

  def obfuscated_after_save
    model = TestModel.new(state_id_number: "D1234567")
    render(InputComponent.new(form: form(model:), method: :state_id_number, label: "ID number", obfuscate: true, input_attrs: {autocomplete: "off"}))
  end

  def obfuscated_with_confirmation_after_save
    model = TestModel.new(routing_number: "021000021")
    render(InputComponent.new(
      form: form(model:),
      method: :routing_number,
      label: "Routing number",
      confirmation_method: :routing_number_confirmation,
      confirmation_label: "Confirm routing number",
      obfuscate: true,
      input_attrs: {inputmode: "numeric", autocomplete: "off"}
    ))
  end
end
