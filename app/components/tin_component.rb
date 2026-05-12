# frozen_string_literal: true

class TinComponent < AttributeBoundFormElementComponent
  def initialize(form:, method:, label:, help_text: nil, required: false)
    super(form:, method:)
    @label = label
    @help_text = help_text
    @required = required
  end
end
