# frozen_string_literal: true

class TooltipComponent < BaseComponent
  def initialize(label:, modal_name:, header: nil)
    @label = label
    @modal_name = modal_name
    @header = header || label
  end
end
