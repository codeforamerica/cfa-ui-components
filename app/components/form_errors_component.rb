# frozen_string_literal: true

class FormErrorsComponent < AttributeBoundFormElementComponent
  def initialize(form:, method:, small: false)
    super(form:, method:)
    @small = small
  end
end
