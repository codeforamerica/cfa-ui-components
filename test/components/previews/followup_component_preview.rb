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

  def prefilled_radio_buttons
    custom_model = TestModel.new(favorite_fruits: "banana")
    render("non_component_previews/prefilled_radio_buttons_followup", model: custom_model)
  end

  def prefilled_checkboxes
    custom_model = TestModel.new(favorite_fruits: ["banana"])
    render("non_component_previews/prefilled_checkboxes_followup", model: custom_model)
  end

  def prefilled_dropdown
    custom_model = TestModel.new(favorite_fruits: "banana")
    render("non_component_previews/prefilled_dropdown_followup", model: custom_model)
  end
end
