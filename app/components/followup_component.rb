# frozen_string_literal: true

class FollowupComponent < ViewComponent::Base
  def initialize(method:, value:)
    @method = method
    @value = value
  end
end
