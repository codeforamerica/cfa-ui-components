# frozen_string_literal: true

class ButtonLinkComponent < ViewComponent::Base
  def initialize(label:, url:, style: :primary, method: :get, turbo: true)
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
    @turbo = turbo
  end
end
