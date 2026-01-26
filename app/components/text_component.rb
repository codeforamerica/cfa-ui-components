# frozen_string_literal: true

class TextComponent < BaseComponent
  def initialize(text:, icon: nil)
    @text = text
    @icon = icon
  end
end
