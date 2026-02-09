# frozen_string_literal: true

class ButtonLinkComponent < ViewComponent::Base
  def initialize(label:, url:, style: :primary, method: :get, size: :large, turbo: true)
    @turbo = turbo
    @label = label
    @url = url
    @button_style =
      case style
      when :primary
        "btn--primary"
      when :secondary
        "btn--secondary"
      when :destructive
        "btn--destructive"
      else
        raise ArgumentError("Invalid button style")
      end
    @method = method
    @button_size =
      case size
      when :large
        "btn--large"
      when :small
        "btn--small"
      else
        raise ArgumentError("Invalid button size")
      end
  end
end
