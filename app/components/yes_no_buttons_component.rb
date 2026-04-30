# frozen_string_literal: true

class YesNoButtonsComponent < BaseComponent
  def initialize(form:, method:, yes_label: nil, no_label: nil, unsure: false, unsure_label: nil, html_attrs: nil)
    super(html_attrs:)
    @form = form
    @method = method
    @yes_label = yes_label || I18n.t("cfaui.yes_no.yes", default: "Yes")
    @no_label = no_label || I18n.t("cfaui.yes_no.no", default: "No")
    @unsure = unsure
    @unsure_label = unsure_label || I18n.t("cfaui.yes_no.unsure", default: "I don't know")
  end
end
