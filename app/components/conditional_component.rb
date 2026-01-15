# frozen_string_literal: true

class ConditionalComponent < ViewComponent::Base
  def initialize(method:, value:)
    @method = method
    @value = value
  end
end
