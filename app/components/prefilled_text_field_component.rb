# frozen_string_literal: true

class PrefilledTextFieldComponent < ViewComponent::Base
  def initialize(label:, text: nil, variant: :primary, heading: nil, css_class: nil)
    @heading = heading
    @css_class = css_class
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
    @variant =
      case variant
      when :primary
        ""
      when :currency
        "text-[22px] text-success font-bold"
      else
        raise ArgumentError.new("Invalid variant")
      end
  end
end
