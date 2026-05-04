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
    "check" => {
      path: "icons/check.svg",
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
    "warn" => {
      path: "icons/alert_triangle.svg",
      alt: "warning"
    },
    "error" => {
      path: "icons/alert_round.svg",
      alt: "error"
    },
    "delete" => {
      path: "icons/delete.svg",
      alt: "delete"
    },
    "arrow_left" => {
      path: "icons/arrow_left.svg",
      alt: "back"
    }
  }.freeze

  def initialize(html_attrs:)
    @html_attrs = html_attrs
  end

  def icon_image_path(icon)
    ICONS.dig(icon.to_s, :path) || ""
  end

  def icon_alt_text(icon)
    base = ICONS.dig(icon.to_s, :alt)
    base ? "#{base} icon" : ""
  end

  # Render the icon as a CSS-masked span so it inherits CSS `color`
  # via `background-color: currentColor`. Uses the same image-rasterization
  # path as `<img src=...>`, preserving pixel-perfect positioning.
  def inline_icon(icon, size: 20, css_class: nil, aria_hidden: false)
    path = ICONS.dig(icon.to_s, :path)
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

  def checkbox_wrap(checkbox_html, small: false)
    size = small ? 16 : 24
    box = small ? "h-4 w-4" : "h-6 w-6"
    icon = inline_icon(:check, size:, aria_hidden: true, css_class: "absolute inset-0 pointer-events-none text-text-default")
    content_tag :span, checkbox_html + icon, class: "cfa-checkbox-wrap relative inline-flex #{box}"
  end
end
