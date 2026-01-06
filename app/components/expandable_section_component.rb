# frozen_string_literal: true

class ExpandableSectionComponent < BaseComponent
  def initialize(summary_text:, icon: nil)
    @summary_text = summary_text
    @icon = icon
  end

end
