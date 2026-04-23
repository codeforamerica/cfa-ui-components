# frozen_string_literal: true

class PrefilledTextFieldComponent < ViewComponent::Base
  def initialize(text:, label:, style: :primary)
    @text =
      case style
      when :primary
        text
      when :currency
        "$" + number_with_delimiter(text)
      else
        raise ArgumentError.new("Invalid style")
      end

    @label = label
    @style =
      case style
      when :primary
        ""
      when :currency
        "text-[22px] text-[#008817] font-bold"
      else
        raise ArgumentError.new("Invalid style")
      end
  end
end
