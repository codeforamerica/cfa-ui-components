class RadioButtonsComponentPreview < FormComponentPreview
  def default
    render(RadioButtonsComponent.new(form: form, method: :pineapple_pizza_preference, collection: self.class.yes_no_options, item_value_method: :value, item_label_method: :label))
  end

  def horizontal
    render(RadioButtonsComponent.new(form: form, method: :pineapple_pizza_preference, collection: self.class.yes_no_options, item_value_method: :value, item_label_method: :label, layout: :horizontal))
  end

  def prefilled
    custom_model = TestModel.new(pineapple_pizza_preference: "yes")
    render(RadioButtonsComponent.new(form: form(model: custom_model), method: :pineapple_pizza_preference, collection: self.class.yes_no_options, item_value_method: :value, item_label_method: :label))
  end

  def with_error
    custom_model = TestModel.new
    custom_model.valid?
    render(RadioButtonsComponent.new(form: form(model: custom_model), method: :pineapple_pizza_preference, collection: self.class.yes_no_options, item_value_method: :value, item_label_method: :label))
  end
end
