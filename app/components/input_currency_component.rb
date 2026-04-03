# frozen_string_literal: true

class InputCurrencyComponent < AttributeBoundFormElementComponent
  def initialize(form:, method:, label:, help_text: nil,  **number_field_kwargs)
    super(form: form, method: method)
    @label = label
    @help_text = help_text
    @number_field_kwargs = number_field_kwargs
  end
end
