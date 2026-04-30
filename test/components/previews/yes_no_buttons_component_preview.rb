class YesNoButtonsComponentPreview < FormComponentPreview
  def default
    render(YesNoButtonsComponent.new(form:, method: :pineapple_pizza_preference))
  end

  def with_unsure
    render(YesNoButtonsComponent.new(form:, method: :pineapple_pizza_preference, unsure: true))
  end

  def custom_labels
    render(YesNoButtonsComponent.new(form:, method: :pineapple_pizza_preference, yes_label: "Sure", no_label: "Nope"))
  end
end
