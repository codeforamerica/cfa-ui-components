# frozen_string_literal: true

class CardComponent < ViewComponent::Base
  renders_one :image
  renders_many :buttons

  def initialize(variant: nil)
    @variant = variant
    case variant
    when nil
      # default
    when :informational
      # handled in template
    else
      raise ArgumentError.new("Invalid card variant")
    end
  end

  def action?
    image? || buttons?
  end

  attr_reader :variant
end
