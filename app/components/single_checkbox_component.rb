# frozen_string_literal: true

class SingleCheckboxComponent < AttributeBoundFormElementComponent
  def initialize(form:, method:, label:, checked: nil, disabled: false, optional: false)
    super(form:, method:)
    @label = label
    @checked = checked
    @disabled = disabled
    @optional = optional
  end
end
