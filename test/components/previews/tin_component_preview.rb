class TinComponentPreview < FormComponentPreview
  def default
    render(TinComponent.new(form:, method: :ssn, label: I18n.t("preview.ssn")))
  end

  def help_text
    render(TinComponent.new(form:, method: :ssn, label: I18n.t("preview.ssn"), help_text: I18n.t("preview.ssn_help")))
  end
end
