# frozen_string_literal: true

class CardComponent < ViewComponent::Base
  renders_one :image
  renders_many :buttons

  def action?
    image? || buttons?
  end
end
