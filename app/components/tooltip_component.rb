# frozen_string_literal: true

class TooltipComponent < BaseComponent
  def initialize(label:, modal_name:)
    @label = label
    @modal_name = modal_name
  end
end
