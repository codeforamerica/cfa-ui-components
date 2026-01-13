class FollowupComponentPreview < FormComponentPreview
  def radio_buttons
    render("non_component_previews/radio_buttons_followup")
  end

  def checkboxes
    render("non_component_previews/checkboxes_followup")
  end

  def dropdown
    render("non_component_previews/dropdown_followup")
  end
end
