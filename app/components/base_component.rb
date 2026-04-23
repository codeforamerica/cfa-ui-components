class BaseComponent < ViewComponent::Base
  attr_accessor :html_attrs

  ICONS = {
    "question" => {
      path: "icons/circle_question.svg",
      alt: "question"
    },
    "info" => {
      path: "icons/circle_info.svg",
      alt: "info"
    },
    "xmark" => {
      path: "icons/xmark.svg",
      alt: "close"
    },
    "circle_check" => {
      path: "icons/circle_check.svg",
      alt: "check mark"
    },
    "circle_xmark" => {
      path: "icons/circle_xmark.svg",
      alt: "x mark"
    },
    "chevron_down" => {
      path: "icons/arrow_closed.svg",
      alt: "chevron down"
    },
    "chevron_up" => {
      path: "icons/arrow_open.svg",
      alt: "chevron up"
    },
    "alert" => {
      path: "icons/alert.svg",
      alt: "alert"
    }
  }.freeze

  def initialize(html_attrs:)
    @html_attrs = html_attrs
  end

  def icon_image_path(icon)
    ICONS.dig(icon, :path) || ""
  end

  def icon_alt_text(icon)
    base = ICONS.dig(icon, :alt)
    base ? "#{base} icon" : ""
  end

  def required_class
    @required ? "required" : ""
  end
end
