# frozen_string_literal: true

class TooltipComponent < BaseComponent
  renders_one :modal_content

  def initialize(label:, modal_name:)
    @label = label
    @modal_name = modal_name
  end
end
