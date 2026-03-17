# frozen_string_literal: true

class CardComponent < ViewComponent::Base
  def initialize(style: :primary)
    @style =
      case style
      when :primary
        "border-zinc-300 border rounded-md p-4 space-y-4"
      when :secondary
        "bg-[#F7F7F7] border-[#B2B2B2] border rounded-md p-4 space-y-4"
      else
        raise ArgumentError.new("Invalid style")
      end
  end
end
