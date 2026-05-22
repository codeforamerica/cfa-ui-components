# frozen_string_literal: true

class TinComponent < AttributeBoundFormElementComponent
  def initialize(form:, method:, label:, help_text: nil, optional: false)
    super(form:, method:)
    @label = label
    @help_text = help_text
    @optional = optional
  end
end
