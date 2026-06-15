# frozen_string_literal: true

class LinkComponent < BaseComponent
  def initialize(label:, url:, external: nil, html_attrs: nil)
    super(html_attrs:)

    @label = label
    @url = url
    @external = external
  end

  #### MAKE SURE WE HAVE AN INLINE OPTION!!!!!!
  def external?
    return @external unless @external.nil?

    @url.to_s.match?(%r{\Ahttps?://})
  end

  def external_link_sr_label
    "External, opens in a new tab"
  end
end
