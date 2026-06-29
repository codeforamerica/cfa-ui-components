# frozen_string_literal: true

class LinkComponent < BaseComponent
  def initialize(label:, url:, sr_label:, external_sr_label:, external: nil, html_attrs: nil)
    super(html_attrs:)

    @label = label
    @url = url
    @external = external
    @sr_label = sr_label
    @external_sr_label = external_sr_label
  end

  def external?
    return @external unless @external.nil?
    return false if @url.to_s.start_with?("https://www.getyourrefund.org/")
    return false if @url.to_s.start_with?("https://simplefile.getyourrefund.org/")
    @url.to_s.match?(%r{\Ahttps?://})
  end

def new_tab?
  return false if @url.to_s.include?("/accounts/sign-in")

  external?
end
end
