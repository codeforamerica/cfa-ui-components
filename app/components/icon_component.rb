# frozen_string_literal: true

class IconComponent < BaseComponent
  # Standalone icons default to the themed icon color (--color-icon-default,
  # i.e. Figma's icon/primary). Pass `css_class:` (e.g. "text-error") to color
  # an icon differently. Icons rendered inside other components go through
  # `inline_icon` directly and keep inheriting `currentColor`.
  #
  # Accessibility — name an icon by its MEANING, never its shape:
  #
  # * Decorative (default): text beside the icon already conveys the meaning
  #   (a button label, a column value). The icon is hidden from assistive tech
  #   so it isn't double-announced. This is the common case, so it's the
  #   default when no `label:` is given.
  # * Meaningful: the icon is the only content (e.g. a status glyph in an
  #   icon-only cell). Pass `label:` with what it conveys ("Yes"/"No"); that
  #   name is exposed and the icon is no longer hidden.
  #
  # `aria_hidden:` can be set explicitly to override the derived default (e.g.
  # `aria_hidden: false` with no label falls back to a humanized icon name like
  # "check circle icon" — a shape-based name that's rarely what you want).
  def initialize(icon:, size: 20, css_class: "text-icon-default", label: nil, aria_hidden: label.nil?)
    @icon = icon
    @size = size
    @css_class = css_class
    @label = label
    @aria_hidden = aria_hidden
  end
end
