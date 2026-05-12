# frozen_string_literal: true

class IconComponent < BaseComponent
  def initialize(icon:, size: 20)
    @icon = icon
    @size = size
  end
end
