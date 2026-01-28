# frozen_string_literal: true

class SubmitButtonComponent < ViewComponent::Base
  def initialize(form:, label: I18n.t("continue"), style: :primary)
    @form = form
    @label = label
    @button_style =
      case style
      when :primary
        "btn--primary"
      when :secondary
        "btn--secondary"
      else
        raise ArgumentError("Invalid button style")
      end
  end
end
