# frozen_string_literal: true

class ConditionalComponent < ViewComponent::Base
  # instance_key must match the instance_key passed to the corresponding
  # RadioButtonsComponent or CheckboxesComponent so this conditional reads the
  # right Alpine store when multiple instances coexist on a page.
  def initialize(method:, value:, content_description: nil, instance_key: nil)
    @method = method
    @value = value
    @content_description = content_description
    @instance_key = instance_key
  end

  private

  def content_description
    @content_description || "Conditional section"
  end

  def store_key
    suffix = @instance_key.present? ? "_#{@instance_key}" : ""
    "#{@method}#{suffix}"
  end
end
