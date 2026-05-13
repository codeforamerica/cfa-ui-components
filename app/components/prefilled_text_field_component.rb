# frozen_string_literal: true

class PrefilledTextFieldComponent < ViewComponent::Base
  def initialize(text:, label:, variant: :primary)
    @text =
      case variant
      when :primary
        text
      when :currency
        "$" + number_with_delimiter(text)
      else
        raise ArgumentError.new("Invalid variant")
      end

    @label = label
    @style =
      case variant
      when :primary
        ""
      when :currency
        "text-[22px] text-[#008817] font-bold"
      else
        raise ArgumentError.new("Invalid variant")
      end
  end
end
