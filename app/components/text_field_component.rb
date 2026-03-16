# frozen_string_literal: true

class TextFieldComponent < AttributeBoundFormElementComponent
  def initialize(form:, method:, label:, help_text: nil, value_type: nil, required: false)
    super(form: form, method: method)
    @label = label
    @help_text = help_text
    @value_type = value_type
    @required = required
  end
end
