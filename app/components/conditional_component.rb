# frozen_string_literal: true

class ConditionalComponent < ViewComponent::Base
  def initialize(method:, value:, content_description: nil, unique_alpine_store_key: "")
    @method = method
    @value = value
    @content_description = content_description
    @unique_alpine_store_key = unique_alpine_store_key
  end

  private

  def content_description
    @content_description || "Conditional section"
  end
end
