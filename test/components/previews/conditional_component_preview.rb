class ConditionalComponentPreview < FormComponentPreview
  def radio_buttons
    render("non_component_previews/radio_buttons_conditional")
  end

  def checkboxes
    render("non_component_previews/checkboxes_conditional")
  end

  def dropdown
    render("non_component_previews/dropdown_conditional")
  end

  def prefilled_radio_buttons
    custom_model = TestModel.new(favorite_fruits: "banana")
    render("non_component_previews/prefilled_radio_buttons_conditional", model: custom_model)
  end

  def prefilled_checkboxes
    custom_model = TestModel.new(favorite_fruits: ["banana"])
    render("non_component_previews/prefilled_checkboxes_conditional", model: custom_model)
  end

  def prefilled_dropdown
    custom_model = TestModel.new(favorite_fruits: "banana")
    render("non_component_previews/prefilled_dropdown_conditional", model: custom_model)
  end
end
