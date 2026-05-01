class RadioButtonsComponentPreview < FormComponentPreview
  # @!group Default
  def default
    render(RadioButtonsComponent.new(form:, method: :pineapple_pizza_preference, collection: self.class.yes_no_options, item_value_method: :value, item_label_method: :label, unique_id: "default"))
  end

  def horizontal
    render(RadioButtonsComponent.new(form:, method: :pineapple_pizza_preference, collection: self.class.yes_no_options, item_value_method: :value, item_label_method: :label, layout: :horizontal, unique_id: "horizontal"))
  end

  def with_legend
    render(RadioButtonsComponent.new(form:, method: :pineapple_pizza_preference, collection: self.class.yes_no_options, item_value_method: :value, item_label_method: :label, legend: "Radio group label", unique_id: "with_legend"))
  end

  def horizontal_with_legend
    render(RadioButtonsComponent.new(form:, method: :pineapple_pizza_preference, collection: self.class.yes_no_options, item_value_method: :value, item_label_method: :label, layout: :horizontal, legend: "Radio group label", unique_id: "horizontal_with_legend"))
  end

  def prefilled
    custom_model = TestModel.new(pineapple_pizza_preference: "yes")
    render(RadioButtonsComponent.new(form: form(model: custom_model), method: :pineapple_pizza_preference, collection: self.class.yes_no_options, item_value_method: :value, item_label_method: :label, unique_id: "prefilled"))
  end

  def with_error
    custom_model = TestModel.new
    custom_model.valid?
    render(RadioButtonsComponent.new(form: form(model: custom_model), method: :pineapple_pizza_preference, collection: self.class.yes_no_options, item_value_method: :value, item_label_method: :label, unique_id: "with_error"))
  end

  def with_warning
    render(RadioButtonsComponent.new(form:, method: :pineapple_pizza_preference, collection: self.class.yes_no_options, item_value_method: :value, item_label_method: :label, warning_message: "Message goes here.", unique_id: "with_warning"))
  end

  def with_error_and_warning
    custom_model = TestModel.new
    custom_model.valid?
    render(RadioButtonsComponent.new(form: form(model: custom_model), method: :pineapple_pizza_preference, collection: self.class.yes_no_options, item_value_method: :value, item_label_method: :label, warning_message: "Message goes here.", unique_id: "with_error_and_warning"))
  end
  # @!endgroup

  # @!group Small
  def small_default
    render(RadioButtonsComponent.new(form:, method: :pineapple_pizza_preference, collection: self.class.yes_no_options, item_value_method: :value, item_label_method: :label, small: true, unique_id: "small_default"))
  end

  def small_prefilled
    custom_model = TestModel.new(pineapple_pizza_preference: "yes")
    render(RadioButtonsComponent.new(form: form(model: custom_model), method: :pineapple_pizza_preference, collection: self.class.yes_no_options, item_value_method: :value, item_label_method: :label, small: true, unique_id: "small_prefilled"))
  end

  def small_with_error
    custom_model = TestModel.new
    custom_model.valid?
    render(RadioButtonsComponent.new(form: form(model: custom_model), method: :pineapple_pizza_preference, collection: self.class.yes_no_options, item_value_method: :value, item_label_method: :label, small: true, unique_id: "small_with_error"))
  end

  def small_with_warning
    render(RadioButtonsComponent.new(form:, method: :pineapple_pizza_preference, collection: self.class.yes_no_options, item_value_method: :value, item_label_method: :label, small: true, warning_message: "Message goes here.", unique_id: "small_with_warning"))
  end

  def small_with_error_and_warning
    custom_model = TestModel.new
    custom_model.valid?
    render(RadioButtonsComponent.new(form: form(model: custom_model), method: :pineapple_pizza_preference, collection: self.class.yes_no_options, item_value_method: :value, item_label_method: :label, small: true, warning_message: "Message goes here.", unique_id: "small_with_error_and_warning"))
  end
  # @!endgroup
end
