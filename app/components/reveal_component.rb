# frozen_string_literal: true

class RevealComponent < BaseComponent
  def initialize(summary_text:, icon: nil, css_class: nil, open: false)
    @summary_text = summary_text
    @icon = icon
    @css_class = css_class
    @open = open
  end
end
