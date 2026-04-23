# frozen_string_literal: true

class SingleCheckboxComponent < AttributeBoundFormElementComponent
  def initialize(form:, method:, label:, checked: nil, disabled: false, required: false)
    super(form:, method:)
    @label = label
    @checked = checked
    @disabled = disabled
  end
end
