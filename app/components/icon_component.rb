# frozen_string_literal: true

class IconComponent < BaseComponent
  # Standalone icons default to the themed icon color (--color-icon-default,
  # i.e. Figma's icon/primary). Pass `css_class:` (e.g. "text-error") to color
  # an icon differently. Icons rendered inside other components go through
  # `inline_icon` directly and keep inheriting `currentColor`.
  def initialize(icon:, size: 20, css_class: "text-icon-default")
    @icon = icon
    @size = size
    @css_class = css_class
  end
end
