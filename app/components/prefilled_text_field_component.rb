# frozen_string_literal: true

class PrefilledTextFieldComponent < ViewComponent::Base
  def initialize(label:, text: nil, style: :primary, heading: nil, css_class: nil)
    @heading = heading
    @css_class = css_class
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
        "text-[22px] text-success font-bold"
      else
        raise ArgumentError.new("Invalid style")
      end
  end
end
