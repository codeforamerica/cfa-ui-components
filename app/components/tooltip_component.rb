# frozen_string_literal: true

class TooltipComponent < BaseComponent
  def initialize(label:, modal_name:, header: nil, css_class: nil)
    @label = label
    @modal_name = modal_name
    @header = header || label
    @css_class = css_class
  end
end
