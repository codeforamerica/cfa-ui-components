# frozen_string_literal: true

class ButtonLinkComponent < BaseComponent
  def initialize(label:, url:, style: :primary, method: :get, size: :large, turbo: true, icon: nil, html_attrs: nil)
    super(html_attrs:)
    @turbo = turbo
    @label = label
    @url = url
    @icon = icon
    @button_style =
      case style
      when :primary
        "btn--primary"
      when :secondary
        "btn--secondary"
      when :destructive
        "btn--destructive"
      else
        raise ArgumentError.new("Invalid button style")
      end
    @method = method
    @button_size =
      case size
      when :large
        "btn--large"
      when :small
        "btn--small"
      else
        raise ArgumentError.new("Invalid button size")
      end
  end
end
