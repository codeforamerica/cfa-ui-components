# frozen_string_literal: true

class LinkComponent < BaseComponent
  def initialize(label:, url:, icon: nil)
    @label = label
    @url = url
    @icon = icon
  end
end
