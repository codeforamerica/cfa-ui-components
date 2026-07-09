# frozen_string_literal: true

class SubmitButtonComponent < ViewComponent::Base
  def initialize(form:, label: I18n.t("cfaui.submit_button.label"), style: :primary, disabled: false, css_class: nil)
    @form = form
    @label = label
    @disabled = disabled
    @css_class = css_class
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
