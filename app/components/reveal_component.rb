# frozen_string_literal: true

class RevealComponent < BaseComponent
  def initialize(summary_text:, icon: nil, style: :primary)
    @summary_text = summary_text
    @icon = icon
    @style = style
  end
end
