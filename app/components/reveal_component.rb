# frozen_string_literal: true

class RevealComponent < BaseComponent
  def initialize(summary_text:, icon: nil, style: :primary)
    @summary_text = summary_text
    @icon = icon
    @style =
      case style
      when :primary
        :grey
      when :white
        :primary
      else
        raise ArgumentError.new("Invalid style")
      end
  end
end
