class BaseComponent < ViewComponent::Base
  ICONS = {
    "question" => {
      path: "icons/circle_question.svg",
      alt:  "question"
    },
    "info" => {
      path: "icons/circle_info.svg",
      alt:  "info"
    },
    "xmark" => {
      path: "icons/xmark.svg",
      alt: "close"
    },
    "circle_check" => {
      path: "icons/circle_check.svg",
      alt:  "check mark"
    },
    "circle_xmark" => {
      path: "icons/circle_xmark.svg",
      alt:  "x mark"
    },
    "chevron_down" => {
      path: "icons/chevron_down.svg",
      alt: "chevron down"
    },
    "chevron_up" => {
      path: "icons/chevron_up.svg",
      alt: "chevron up"
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
