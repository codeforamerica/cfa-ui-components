# frozen_string_literal: true

class RevealComponent < BaseComponent
  def initialize(summary_text:, icon: nil, style: :primary)
    @summary_text = summary_text
    @icon = icon
    @card_style =
      case style
      when :primary
        :secondary
      when :secondary
        :primary
      else
        raise ArgumentError.new("Invalid style")
      end
  end
end
