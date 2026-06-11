# frozen_string_literal: true

class IconComponentPreview < ViewComponent::Preview
  # Renders every icon the engine can draw: all USWDS sprite symbols plus our
  # standalone masked icons (e.g. `loading`, `clock`). Hover any cell to see
  # its name. Pass that name to `IconComponent.new(icon:)`.
  def gallery
    render_with_template(locals: {icons: icon_names})
  end

  private

  def icon_names
    (BaseComponent::USWDS_ICON_IDS.to_a + BaseComponent::NON_USWDS_ICON_IDS.keys).sort
  end
end
