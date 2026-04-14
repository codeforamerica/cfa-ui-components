# frozen_string_literal: true

class InputCurrencyComponent < AttributeBoundFormElementComponent
  def initialize(form:, method:, label:, help_text: nil, required: false, **number_field_kwargs)
    super(form: form, method: method)
    @label = label
    @help_text = help_text
    @required = required
    @number_field_kwargs = number_field_kwargs
  end

  def input_kwargs
    {
      inputmode: "decimal",
      class: "w-full rounded-sm border border-zinc-900 pl-7 pr-3 py-2",
      "x-data": "{ value: '' }",
      "x-model": "value",
      "x-on:input": "value = formatCurrency($event.target.value)",
      "x-init": "value = $el.value"
    }.merge(@number_field_kwargs)
  end
end
