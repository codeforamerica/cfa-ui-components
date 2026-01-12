# frozen_string_literal: true

class TextFieldComponent < ViewComponent::Base
  TIN = :tin

  def initialize(form:, method:, label:, help_text: nil, value_type: nil, required: false)
    @form = form
    @method = method
    @label = label
    @help_text = help_text
    @value_type = value_type
    @required = required
  end

  private

  def text_field_kwargs
    kwargs = {}
    if @value_type == TIN
      kwargs["x-mask"] = "999-99-9999"
      kwargs["placeholder"] = "___-__-____"
    end
    kwargs
  end

  def required_class
    @required ? "required" : ""
  end
end
