# frozen_string_literal: true

class BackButtonComponent < BaseComponent
  def initialize(back_url:, disabled: false, html_attrs: nil)
    super(html_attrs:)
    @back_url = back_url
    @disabled = disabled
  end
end
