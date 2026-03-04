class TinComponentPreview < FormComponentPreview
  def default
    render(TinComponent.new(form: form, method: :ssn, label: I18n.t(:ssn)))
  end
end
