# frozen_string_literal: true

class ConditionalComponent < ViewComponent::Base
  def initialize(method:, value:, content_description: nil)
    @method = method
    @value = value
    @content_description = content_description
    puts "method #{method} value #{value}"
  end

  private

  def content_description
    @content_description || "Conditional section"
  end
end
