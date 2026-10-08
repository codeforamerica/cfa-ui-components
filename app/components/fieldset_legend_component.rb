# frozen_string_literal: true

# The <legend> for a group component's <fieldset>: either a screen-reader-only
# `legend:` (the visible question lives elsewhere on the page) or a visible
# `heading:` rendered as <legend><hN>, so the fieldset names itself.
class FieldsetLegendComponent < ViewComponent::Base
  HEADING_LEVELS = (1..6)

  def initialize(legend: nil, heading: nil, heading_level: 2)
    raise ArgumentError, "pass legend: or heading:, not both" if legend && heading
    raise ArgumentError, "heading_level must be 1-6" unless HEADING_LEVELS.cover?(heading_level)
    @legend = legend
    @heading = heading
    @heading_level = heading_level
  end

  def render?
    @legend.present? || @heading.present?
  end
end
