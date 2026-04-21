# frozen_string_literal: true

class InputCurrencyComponent < AttributeBoundFormElementComponent
  def initialize(form:, method:, label:, help_text: nil, required: false, **number_field_kwargs)
    super(form:, method:)
    @label = label
    @help_text = help_text
    @required = required
    @number_field_kwargs = number_field_kwargs
  end
end
