# frozen_string_literal: true

class RevealComponent < BaseComponent
  def initialize(summary_text:, icon: nil, css_class: nil, open: false, reveal_id: nil)
    @summary_text = summary_text
    @icon = icon
    @css_class = css_class
    @open = open
    @reveal_id = reveal_id
  end

  # Opt this reveal into analytics only when a `reveal_id` is given. The gem
  # stays provider-agnostic: it emits a `cfa:analytics` DOM event (see
  # analytics_emitter.ts); the host app routes it to Mixpanel or elsewhere.
  def analytics_attrs
    return {} if @reveal_id.blank?
    {"data-analytics-event" => "reveal_clicked", "data-analytics-id" => @reveal_id}
  end
end
