# frozen_string_literal: true

class ExclusiveCheckboxGroupComponent < ViewComponent::Base
  renders_one :exclusive_option

  def initialize(legend: nil, aria_labelledby: nil)
    raise ArgumentError, "must provide legend: or aria_labelledby:" if legend.nil? && aria_labelledby.nil?
    @legend = legend
    @aria_labelledby = aria_labelledby
  end
end
