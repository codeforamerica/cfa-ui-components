class RadioButtonsComponentPreview < FormComponentPreview
  # @!group Default
  def default
    render(RadioButtonsComponent.new(form: form(scope: :radio_default), method: :pineapple_pizza_preference, collection: self.class.yes_no_options, item_value_method: :value, item_label_method: :label, scope: "default", legend: "Do you like pineapple on pizza?"))
  end

  def horizontal
    render(RadioButtonsComponent.new(form: form(scope: :radio_horizontal), method: :pineapple_pizza_preference, collection: self.class.yes_no_options, item_value_method: :value, item_label_method: :label, layout: :horizontal, scope: "horizontal", legend: "Do you like pineapple on pizza?"))
  end

  def with_legend
    render(RadioButtonsComponent.new(form: form(scope: :radio_with_legend), method: :pineapple_pizza_preference, collection: self.class.yes_no_options, item_value_method: :value, item_label_method: :label, legend: "Radio group label", scope: "with_legend"))
  end

  def horizontal_with_legend
    render(RadioButtonsComponent.new(form: form(scope: :radio_horizontal_with_legend), method: :pineapple_pizza_preference, collection: self.class.yes_no_options, item_value_method: :value, item_label_method: :label, layout: :horizontal, legend: "Radio group label", scope: "horizontal_with_legend"))
  end

  def prefilled
    custom_model = TestModel.new(pineapple_pizza_preference: "yes")
    render(RadioButtonsComponent.new(form: form(model: custom_model, scope: :radio_prefilled), method: :pineapple_pizza_preference, collection: self.class.yes_no_options, item_value_method: :value, item_label_method: :label, scope: "prefilled", legend: "Do you like pineapple on pizza?"))
  end

  def with_error
    custom_model = TestModel.new
    custom_model.valid?
    render(RadioButtonsComponent.new(form: form(model: custom_model, scope: :radio_with_error), method: :pineapple_pizza_preference, collection: self.class.yes_no_options, item_value_method: :value, item_label_method: :label, scope: "with_error", legend: "Do you like pineapple on pizza?"))
  end

  def with_warning
    render(RadioButtonsComponent.new(form: form(scope: :radio_with_warning), method: :pineapple_pizza_preference, collection: self.class.yes_no_options, item_value_method: :value, item_label_method: :label, warning_message: "Message goes here.", scope: "with_warning", legend: "Do you like pineapple on pizza?"))
  end

  def with_error_and_warning
    custom_model = TestModel.new
    custom_model.valid?
    render(RadioButtonsComponent.new(form: form(model: custom_model, scope: :radio_with_error_and_warning), method: :pineapple_pizza_preference, collection: self.class.yes_no_options, item_value_method: :value, item_label_method: :label, warning_message: "Message goes here.", scope: "with_error_and_warning", legend: "Do you like pineapple on pizza?"))
  end
  # @!endgroup

  # @!group Bordered
  def bordered
    render(RadioButtonsComponent.new(form: form(scope: :radio_bordered), method: :pineapple_pizza_preference, collection: self.class.yes_no_options, item_value_method: :value, item_label_method: :label, bordered: true, scope: "bordered", legend: "Do you like pineapple on pizza?"))
  end

  def bordered_with_warning
    render(RadioButtonsComponent.new(form: form(scope: :radio_bordered_with_warning), method: :pineapple_pizza_preference, collection: self.class.yes_no_options, item_value_method: :value, item_label_method: :label, bordered: true, warning_message: "Message goes here.", scope: "bordered_with_warning", legend: "Do you like pineapple on pizza?"))
  end

  def bordered_with_error_and_warning
    custom_model = TestModel.new
    custom_model.valid?
    render(RadioButtonsComponent.new(form: form(model: custom_model, scope: :radio_bordered_with_error_and_warning), method: :favorite_fruits, collection: self.class.fruit_options, item_value_method: :value, item_label_method: :label, bordered: true, warning_message: "Message goes here.", scope: "bordered_with_error_and_warning", legend: "Which fruits?"))
  end
  # @!endgroup

  # @!group Small
  def small_default
    render(RadioButtonsComponent.new(form: form(scope: :radio_small_default), method: :pineapple_pizza_preference, collection: self.class.yes_no_options, item_value_method: :value, item_label_method: :label, small: true, scope: "small_default", legend: "Do you like pineapple on pizza?"))
  end

  def small_prefilled
    custom_model = TestModel.new(pineapple_pizza_preference: "yes")
    render(RadioButtonsComponent.new(form: form(model: custom_model, scope: :radio_small_prefilled), method: :pineapple_pizza_preference, collection: self.class.yes_no_options, item_value_method: :value, item_label_method: :label, small: true, scope: "small_prefilled", legend: "Do you like pineapple on pizza?"))
  end

  def small_with_error
    custom_model = TestModel.new
    custom_model.valid?
    render(RadioButtonsComponent.new(form: form(model: custom_model, scope: :radio_small_with_error), method: :pineapple_pizza_preference, collection: self.class.yes_no_options, item_value_method: :value, item_label_method: :label, small: true, scope: "small_with_error", legend: "Do you like pineapple on pizza?"))
  end

  def small_with_warning
    render(RadioButtonsComponent.new(form: form(scope: :radio_small_with_warning), method: :pineapple_pizza_preference, collection: self.class.yes_no_options, item_value_method: :value, item_label_method: :label, small: true, warning_message: "Message goes here.", scope: "small_with_warning", legend: "Do you like pineapple on pizza?"))
  end

  def small_with_error_and_warning
    custom_model = TestModel.new
    custom_model.valid?
    render(RadioButtonsComponent.new(form: form(model: custom_model, scope: :radio_small_with_error_and_warning), method: :pineapple_pizza_preference, collection: self.class.yes_no_options, item_value_method: :value, item_label_method: :label, small: true, warning_message: "Message goes here.", scope: "small_with_error_and_warning", legend: "Do you like pineapple on pizza?"))
  end
  # @!endgroup
end
