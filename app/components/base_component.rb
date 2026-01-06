class BaseComponent < ViewComponent::Base
  ICONS = {
    "question" => {
      path: "icons/question_mark_circle.svg",
      alt:  "question"
    },
    "info" => {
      path: "icons/information.svg",
      alt:  "info"
    }
  }.freeze

  def icon_image_path(icon)
    ICONS.dig(icon, :path) || ""
  end

  def icon_alt_text(icon)
    base = ICONS.dig(icon, :alt)
    base ? "#{base} icon" : ""
  end
end
