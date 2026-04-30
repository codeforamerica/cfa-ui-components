# frozen_string_literal: true

class SubmitButtonComponent < ViewComponent::Base
  def initialize(form:, label: I18n.t("continue"), style: :primary, disabled: false)
    @form = form
    @label = label
    @disabled = disabled
    @button_style =
      case style
      when :primary
        "btn--primary"
      when :secondary
        "btn--secondary"
      else
        raise ArgumentError.new("Invalid button style")
      end
  end
end
