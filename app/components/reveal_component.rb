# frozen_string_literal: true

class RevealComponent < BaseComponent
  def initialize(summary_text:, icon: nil)
    @summary_text = summary_text
    @icon = icon
  end
end
