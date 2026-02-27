class TinComponentPreview < FormComponentPreview
  def default
    render(TinComponent.new(form: form, method: :first_name, label: I18n.t(:first_name)))
  end
end
