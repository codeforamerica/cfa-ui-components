# frozen_string_literal: true

class SingleCheckboxComponent < AttributeBoundFormElementComponent
  def initialize(form:, method:, label:, checked: nil, disabled: false, optional: false, css_class: nil)
    super(form:, method:, css_class:)
    @label = label
    @checked = checked
    @disabled = disabled
    @optional = optional
  end
end
