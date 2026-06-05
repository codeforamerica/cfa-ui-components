# frozen_string_literal: true

class InputComponent < AttributeBoundFormElementComponent
  def initialize(form:, method:, label:, help_text: nil, optional: false, css_class: nil)
    super(form:, method:, css_class:)
    @label = label
    @help_text = help_text
    @optional = optional
  end
end
