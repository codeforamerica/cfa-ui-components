class TinComponentPreview < FormComponentPreview
  def default
    render(TinComponent.new(form: form, method: :ssn, label: I18n.t(:ssn)))
  end

  def help_text
    render(TinComponent.new(form: form, method: :ssn, label: I18n.t(:ssn), help_text: I18n.t(:ssn_help)))
  end
end
