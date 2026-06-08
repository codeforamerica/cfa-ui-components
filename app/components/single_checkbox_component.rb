# frozen_string_literal: true

class SingleCheckboxComponent < AttributeBoundFormElementComponent
  def initialize(form:, method:, label:, checked: nil, disabled: false, optional: false, css_class: nil, input_attrs: {})
    super(form:, method:, css_class:, input_attrs:)
    @label = label
    @checked = checked
    @disabled = disabled
    @optional = optional
  end
end
