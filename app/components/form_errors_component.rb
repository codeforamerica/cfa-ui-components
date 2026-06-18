# frozen_string_literal: true

class FormErrorsComponent < AttributeBoundFormElementComponent
  def initialize(form:, method:, small: false, css_class: nil)
    super(form:, method:, css_class:)
    @small = small
  end
end
