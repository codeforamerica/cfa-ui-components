# frozen_string_literal: true

class PrefilledTextFieldComponent < ViewComponent::Base
  def initialize(text:,  label:,  style: :primary)
    @text = text
    @label = label
    @style =
      case style
      when :primary
        ""
      when :numeric
        "text-[22px] text-[#008817] font-bold"
      else
        raise ArgumentError("Invalid style")
      end
  end
end
