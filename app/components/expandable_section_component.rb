# frozen_string_literal: true

class ExpandableSectionComponent < ViewComponent::Base
  def initialize(summary_text:, detail_text:, icon: nil)
    @summary_text = summary_text
    @detail_text = detail_text
    @icon = icon
  end

  def icon_image_path
    case @icon
    when "question"
      "icons/question_mark_circle.svg"
    else
      ""
    end
  end

  def icon_alt_text
    descriptor = case @icon
    when "question"
      "question icon"
    else
      ""
    end
    descriptor + " icon"
  end
end
