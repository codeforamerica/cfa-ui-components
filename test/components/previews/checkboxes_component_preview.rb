class CheckboxesComponentPreview < FormComponentPreview
  # @!group Default
  def default
    render(CheckboxesComponent.new(form:, method: :favorite_fruits, collection: self.class.fruit_options, item_value_method: :value, item_label_method: :label, unique_id: "default"))
  end

  def prefilled
    custom_model = TestModel.new(favorite_fruits: ["apple", "orange"])
    render(CheckboxesComponent.new(form: form(model: custom_model), method: :favorite_fruits, collection: self.class.fruit_options, item_value_method: :value, item_label_method: :label, unique_id: "prefilled"))
  end

  def with_error
    custom_model = TestModel.new
    custom_model.valid?
    render(CheckboxesComponent.new(form: form(model: custom_model), method: :favorite_fruits, collection: self.class.fruit_options, item_value_method: :value, item_label_method: :label, unique_id: "with_error"))
  end

  def with_warning
    render(CheckboxesComponent.new(form:, method: :favorite_fruits, collection: self.class.fruit_options, item_value_method: :value, item_label_method: :label, warning_message: "Message goes here.", unique_id: "with_warning"))
  end

  def indeterminate
    render(CheckboxesComponent.new(form:, method: :favorite_fruits, collection: self.class.fruit_options, item_value_method: :value, item_label_method: :label, item_states: {"orange" => :indeterminate}, unique_id: "indeterminate"))
  end

  def disabled_item
    render(CheckboxesComponent.new(form:, method: :favorite_fruits, collection: self.class.fruit_options, item_value_method: :value, item_label_method: :label, item_states: {"orange" => :disabled}, unique_id: "disabled_item"))
  end

  def mixed_states
    render(CheckboxesComponent.new(form:, method: :favorite_fruits, collection: self.class.fruit_options, item_value_method: :value, item_label_method: :label, item_states: {"orange" => :indeterminate, "apple" => :disabled}, unique_id: "mixed_states"))
  end
  # @!endgroup

  # @!group Small
  def small_default
    render(CheckboxesComponent.new(form:, method: :favorite_fruits, collection: self.class.fruit_options, item_value_method: :value, item_label_method: :label, small: true, unique_id: "small_default"))
  end

  def small_prefilled
    custom_model = TestModel.new(favorite_fruits: ["apple", "orange"])
    render(CheckboxesComponent.new(form: form(model: custom_model), method: :favorite_fruits, collection: self.class.fruit_options, item_value_method: :value, item_label_method: :label, small: true, unique_id: "small_prefilled"))
  end

  def small_with_error
    custom_model = TestModel.new
    custom_model.valid?
    render(CheckboxesComponent.new(form: form(model: custom_model), method: :favorite_fruits, collection: self.class.fruit_options, item_value_method: :value, item_label_method: :label, small: true, unique_id: "small_with_error"))
  end

  def small_with_warning
    render(CheckboxesComponent.new(form:, method: :favorite_fruits, collection: self.class.fruit_options, item_value_method: :value, item_label_method: :label, small: true, warning_message: "Message goes here.", unique_id: "small_with_warning"))
  end

  def small_indeterminate
    render(CheckboxesComponent.new(form:, method: :favorite_fruits, collection: self.class.fruit_options, item_value_method: :value, item_label_method: :label, small: true, item_states: {"orange" => :indeterminate}, unique_id: "small_indeterminate"))
  end
  # @!endgroup
end
