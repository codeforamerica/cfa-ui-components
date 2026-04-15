# frozen_string_literal: true

class TooltipComponent < BaseComponent
  renders_one :modal_content

  def initialize(label:, modal_name:, body: nil)
    @label = label
    @modal_name = modal_name
    @body = body
  end

  def render_modal?
    @body.present? || modal_content?
  end
end
