class BaseComponent < ViewComponent::Base
  attr_accessor :html_attrs

  # Path (relative to the asset pipeline) of the USWDS icon sprite.
  SPRITE_PATH = "uswds-sprite.svg"

  # The set of `id`s defined as `<symbol>`s in the sprite. Read once from the
  # sprite shipped with the engine so `inline_icon` can ignore unknown names.
  SPRITE_ICON_IDS = File.read(
    CfaUiComponents::Engine.root.join("app/assets/images", SPRITE_PATH)
  ).scan(/<symbol id="([^"]+)"/).flatten.to_set.freeze

  # Icons that ship as standalone SVG files, rendered as CSS-masked spans so
  # they inherit color via `background-color: currentColor`. Used for icons
  # with no USWDS sprite equivalent: the animated `loading` spinner, and our
  # filled `clock` (the solid counterpart to the sprite's outline `alarm`).
  MASKED_ICON_PATHS = {
    "loading" => "icons/loading.svg",
    "clock" => "icons/clock.svg"
  }.freeze

  def initialize(html_attrs:)
    @html_attrs = html_attrs
  end

  # Render a USWDS sprite icon as an inline `<svg>` referencing the sprite via
  # `<use>`. The icon inherits the surrounding text color through CSS
  # `fill: currentColor` (see icons.css). Unknown names render nothing.
  #
  # `name` is a USWDS symbol id (e.g. "close", "check_circle") or one of our
  # file-based icons (see MASKED_ICON_PATHS, e.g. "loading", "clock").
  def inline_icon(name, size: 20, css_class: nil, aria_hidden: false, label: nil)
    name = name.to_s
    if (path = MASKED_ICON_PATHS[name])
      return masked_icon(path, name, size:, css_class:, aria_hidden:, label:)
    end
    return "".html_safe unless SPRITE_ICON_IDS.include?(name)

    href = "#{image_path(SPRITE_PATH)}##{name}"
    content_tag :svg, content_tag(:use, "", href:),
      class: ["cfa-icon", css_class].compact,
      width: size, height: size,
      **icon_aria(name, aria_hidden:, label:)
  end

  private

  def icon_aria(name, aria_hidden:, label:)
    return {"aria-hidden" => "true", "focusable" => "false"} if aria_hidden
    {:role => "img", "aria-label" => label || "#{name.tr("_", " ")} icon"}
  end

  # CSS-masked span for a file-based icon, which inherits color via
  # `background-color: currentColor`.
  def masked_icon(path, name, size:, css_class:, aria_hidden:, label:)
    style = "--icon-url: url('#{image_path(path)}'); width: #{size}px; height: #{size}px"
    content_tag :span, "", class: ["cfa-icon-mask", css_class].compact, style:,
      **icon_aria(name, aria_hidden:, label:)
  end

  public

  def label_with_optional_marker
    return @label unless @optional
    safe_join([@label, " ", tag.span("(#{I18n.t("cfaui.optional")})", class: "font-normal")])
  end

  def aria_required_attrs
    @optional ? {} : {"aria-required" => "true"}
  end

  def checkbox_wrap(checkbox_html, small: false)
    size = small ? 16 : 24
    box = small ? "h-4 w-4" : "h-6 w-6"
    icon = inline_icon(:check, size:, aria_hidden: true, css_class: "absolute inset-0 pointer-events-none text-icon-default")
    content_tag :span, checkbox_html + icon, class: "cfa-checkbox-wrap relative inline-flex #{box}"
  end
end
