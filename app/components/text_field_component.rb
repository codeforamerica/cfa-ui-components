# frozen_string_literal: true

class TextFieldComponent < AttributeBoundFormElementComponent
  TIN = :tin

  def initialize(form:, method:, label:, help_text: nil, value_type: nil, required: false)
    super(form: form, method: method)
    @label = label
    @help_text = help_text
    @value_type = value_type
    @required = required
  end

  private

  def text_field_kwargs
    return {} unless @value_type == TIN

    { "x-data" => "{}", "x-mask" => "999-99-9999", "placeholder" => "___-__-____" }
  end
end
