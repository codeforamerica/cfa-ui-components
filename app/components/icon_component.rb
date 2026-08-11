# frozen_string_literal: true

class IconComponent < BaseComponent
  # Standalone icons default to the themed icon color (--color-icon-default).
  # Pass `css_class:` (e.g. "text-error") to recolor. Icons inside other
  # components use `inline_icon` and inherit `currentColor`.
  #
  # Accessibility — name an icon by its MEANING, not its shape:
  # * No `label:` (default): decorative — nearby text conveys the meaning, so
  #   the icon is hidden from assistive tech to avoid double-announcing.
  # * `label:` given: meaningful — the icon is the sole content; the label is
  #   exposed as its name and the icon is no longer hidden.
  #
  # Set `aria_hidden:` explicitly to override the derived default. (Note:
  # `aria_hidden: false` with no label exposes a shape-based name like
  # "check circle icon" — rarely what you want.)
  def initialize(icon:, size: 20, css_class: "text-icon-default", label: nil, aria_hidden: label.nil?)
    @icon = icon
    @size = size
    @css_class = css_class
    @label = label
    @aria_hidden = aria_hidden
  end
end
