# frozen_string_literal: true

class ExclusiveCheckboxGroupComponent < ViewComponent::Base
  renders_one :exclusive_option

  def initialize(legend: nil, heading: nil, heading_level: 2, aria_labelledby: nil)
    raise ArgumentError, "must provide legend:, heading:, or aria_labelledby:" if legend.nil? && heading.nil? && aria_labelledby.nil?
    @legend = legend
    @heading = heading
    @heading_level = heading_level
    @aria_labelledby = aria_labelledby
  end
end
