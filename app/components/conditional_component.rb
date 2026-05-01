# frozen_string_literal: true

class ConditionalComponent < ViewComponent::Base
  # scope must match the scope passed to the corresponding
  # RadioButtonsComponent or CheckboxesComponent so this conditional reads the
  # right Alpine store when multiple instances coexist on a page.
  def initialize(method:, value:, content_description: nil, scope: nil)
    @method = method
    @value = value
    @content_description = content_description
    @scope = scope
  end

  private

  def content_description
    @content_description || "Conditional section"
  end

  def store_key
    suffix = @scope.present? ? "_#{@scope}" : ""
    "#{@method}#{suffix}"
  end
end
