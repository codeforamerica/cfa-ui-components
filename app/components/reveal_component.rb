# frozen_string_literal: true

class RevealComponent < BaseComponent
  def initialize(summary_text:, icon: nil, css_class: nil)
    @summary_text = summary_text
    @icon = icon
    @css_class = css_class
  end
end
