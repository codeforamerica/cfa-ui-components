class TinComponentPreview < FormComponentPreview
  def default
    render(TinComponent.new(form:, method: :ssn, label: I18n.t(:ssn)))
  end

  def help_text
    render(TinComponent.new(form:, method: :ssn, label: I18n.t(:ssn), help_text: I18n.t(:ssn_help)))
  end

  # TIN paired with a confirmation field (first entry, nothing saved yet).
  def with_confirmation
    render(TinComponent.new(
      form:,
      method: :ssn,
      label: I18n.t(:ssn),
      help_text: I18n.t(:ssn_help),
      confirmation_method: :ssn_confirmation,
      confirmation_label: "Confirm #{I18n.t(:ssn)}"
    ))
  end

  # Revisiting after a value was saved: shows the obfuscated value with an Edit
  # button. Choosing Edit reveals the empty fields; Cancel restores this view.
  def obfuscated_after_save
    render(TinComponent.new(
      form: form(model: TestModel.new(ssn: "123456789")),
      method: :ssn,
      label: I18n.t(:ssn),
      help_text: I18n.t(:ssn_help),
      confirmation_method: :ssn_confirmation,
      confirmation_label: "Confirm #{I18n.t(:ssn)}"
    ))
  end
end
