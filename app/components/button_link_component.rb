# frozen_string_literal: true

class ButtonLinkComponent < BaseComponent
  def initialize(label:, url:, variant: :primary, method: :get, size: :large, turbo: true, icon: nil, html_attrs: nil)
    super(html_attrs:)
    @turbo = turbo
    @label = label
    @url = url
    @icon = icon
    @method = method
    case variant
    when :primary
      @button_style = "btn--primary"
    when :secondary
      @button_style = "btn--secondary"
    when :destructive
      @button_style = "btn--destructive"
      @method = :delete
      @icon = "delete"
    else
      raise ArgumentError.new("Invalid button variant")
    end
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
