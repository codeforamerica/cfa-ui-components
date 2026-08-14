# frozen_string_literal: true

class AlertComponent < BaseComponent
  def initialize(variant: :warning, title: nil, dismissible: false, css_class: nil)
    @title = title
    @dismissible = dismissible
    @css_class = css_class

    case variant
    when :warning
      @icon_name = :warning_outline
      @icon_class = "text-icon-default"
      @variant_classes = "bg-background-secondary"
    else
      raise ArgumentError.new("Invalid alert variant")
    end
  end

  attr_reader :title, :dismissible, :icon_name, :icon_class, :variant_classes
end
