# frozen_string_literal: true

class NumberFieldComponent < AttributeBoundFormElementComponent
  def initialize(form:, method:, label:, max_num:, min_num: 0.00, step_num: 0.01, help_text: nil, value_type: nil, required: false)
    super(form: form, method: method)
    @label = label
    @help_text = help_text
    @value_type = value_type
    @required = required
    @min_num = min_num
    @max_num = max_num
    @step_num = step_num
  end
end
