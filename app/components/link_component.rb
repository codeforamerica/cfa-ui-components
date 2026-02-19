# frozen_string_literal: true

class LinkComponent < BaseComponent
  def initialize(label:, url:, icon: nil, html_attrs: nil)
    super(html_attrs:)

    @label = label
    @url = url
    @icon = icon
  end
end
