# frozen_string_literal: true

class ButtonLinkComponent < BaseComponent
  def initialize(label:, url:, variant: :primary, method: nil, size: :large, turbo: true, icon: nil, html_attrs: nil)
    super(html_attrs:)
    @turbo = turbo
    @label = label
    @url = url
    case variant
    when :primary
      @button_style = "btn--primary"
      @method = method || :get
      @icon = icon
    when :secondary
      @button_style = "btn--secondary"
      @method = method || :get
      @icon = icon
    when :destructive
      @button_style = "btn--destructive"
      @method = method || :delete
      @icon = icon || "delete"
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
    @icon_size = (size == :small) ? 16 : 20
  end
end
