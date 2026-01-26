class BaseComponent < ViewComponent::Base
  ICONS = {
    "question" => {
      path: "icons/question_mark_circle.svg",
      alt:  "question"
    },
    "info" => {
      path: "icons/information.svg",
      alt:  "info"
    },
    "check_mark" => {
      path: "icons/check_mark.svg",
      alt:  "check mark"
    },
    "x_mark" => {
      path: "icons/x_mark.svg",
      alt:  "x mark"
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
