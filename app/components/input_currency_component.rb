# frozen_string_literal: true

class InputCurrencyComponent < AttributeBoundFormElementComponent
  def initialize(form:, method:, label:, help_text: nil, optional: false, css_class: nil, **number_field_kwargs)
    super(form:, method:, css_class:)
    @label = label
    @help_text = help_text
    @optional = optional
    @number_field_kwargs = number_field_kwargs
  end
end
