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
    },
    "delete" => {
      path: "icons/delete.svg",
      alt: "delete"
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

  # Render the icon as a CSS-masked span so it inherits CSS `color`
  # via `background-color: currentColor`. Uses the same image-rasterization
  # path as `<img src=...>`, preserving pixel-perfect positioning.
  def inline_icon(icon, size: 20, css_class: nil, aria_hidden: false)
    path = ICONS.dig(icon, :path)
    return "".html_safe unless path

    style = "--icon-url: url('#{image_path(path)}'); width: #{size}px; height: #{size}px"
    aria = aria_hidden ?
      {"aria-hidden" => "true"} :
      {:role => "img", "aria-label" => icon_alt_text(icon)}

    content_tag :span, "", class: ["cfa-icon", css_class].compact, style:, **aria
  end

  def required_class
    @required ? "required" : ""
  end
end
