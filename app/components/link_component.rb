# frozen_string_literal: true

class LinkComponent < BaseComponent
  def initialize(label:, url:, sr_label: nil, external_sr_label: nil, external: nil, new_tab: nil, html_attrs: nil)
    super(html_attrs:)

    @label = label
    @url = url
    @external = external
    @new_tab = new_tab
    @sr_label = sr_label || I18n.t("cfaui.link.sr_label")
    @external_sr_label = external_sr_label || I18n.t("cfaui.link.external_sr_label")
  end

  # Whether to show the "external link" affordance (launch icon + external
  # screen-reader label). The host-level decision of what counts as external
  # is the consuming app's responsibility — pass `external:` explicitly when
  # the default heuristic (any absolute http(s) URL) is wrong.
  def external?
    return @external unless @external.nil?
    return false if @url.to_s.start_with?("https://www.getyourrefund.org/")
    return false if @url.to_s.start_with?("https://simplefile.getyourrefund.org/")

    @url.to_s.match?(%r{\Ahttps?://})
  end

  # Whether the link opens in a new tab. Defaults to true; pass `new_tab: false`
  # for links that should stay in the same tab (e.g. an in-app sign-in link).
  def new_tab?
    return @new_tab unless @new_tab.nil?
    true
  end
end
