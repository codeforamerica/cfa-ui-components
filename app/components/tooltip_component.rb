# frozen_string_literal: true

class TooltipComponent < BaseComponent
  def initialize(label:, modal_name:, header: nil, css_class: nil, tooltip_id: nil)
    @label = label
    @modal_name = modal_name
    @header = header || label
    @css_class = css_class
    @tooltip_id = tooltip_id || modal_name.tr("-", "_")
  end

  # Emits a provider-agnostic `cfa:analytics` DOM event on click (see
  # analytics_emitter.ts); the host app routes it to Mixpanel or elsewhere.
  def analytics_attrs
    return {} if @tooltip_id.blank?
    {"data-analytics-event" => "tooltip_clicked", "data-analytics-id" => qualified_analytics_id(@tooltip_id)}
  end
end
