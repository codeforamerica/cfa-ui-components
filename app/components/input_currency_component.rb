# frozen_string_literal: true

class InputCurrencyComponent < AttributeBoundFormElementComponent
  def initialize(form:, method:, label:, max_num:, min_num: 0, step_num: 0.01, help_text: nil, required: false)
    super(form: form, method: method)
    @label = label
    @help_text = help_text
    @required = required
    @min_num = min_num
    @max_num = max_num
    @step_num = step_num
  end
end
