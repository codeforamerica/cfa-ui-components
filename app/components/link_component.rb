# frozen_string_literal: true

class LinkComponent < BaseComponent
  def initialize(label:, url:, icon: false, html_attrs: nil)
    super(html_attrs:)

    @label = label
    @url = url
    @icon = icon
  end
end
