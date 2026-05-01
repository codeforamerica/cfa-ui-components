class CheckboxesComponentPreview < FormComponentPreview
  # @!group Default
  def default
    render(CheckboxesComponent.new(form:, method: :favorite_fruits, collection: self.class.fruit_options, item_value_method: :value, item_label_method: :label, instance_key: "default"))
  end

  def prefilled
    custom_model = TestModel.new(favorite_fruits: ["apple", "orange"])
    render(CheckboxesComponent.new(form: form(model: custom_model), method: :favorite_fruits, collection: self.class.fruit_options, item_value_method: :value, item_label_method: :label, instance_key: "prefilled"))
  end

  def with_error
    custom_model = TestModel.new
    custom_model.valid?
    render(CheckboxesComponent.new(form: form(model: custom_model), method: :favorite_fruits, collection: self.class.fruit_options, item_value_method: :value, item_label_method: :label, instance_key: "with_error"))
  end

  def with_warning
    render(CheckboxesComponent.new(form:, method: :favorite_fruits, collection: self.class.fruit_options, item_value_method: :value, item_label_method: :label, warning_message: "Message goes here.", instance_key: "with_warning"))
  end

  def indeterminate
    render(CheckboxesComponent.new(form:, method: :favorite_fruits, collection: self.class.fruit_options, item_value_method: :value, item_label_method: :label, item_states: {"orange" => :indeterminate}, instance_key: "indeterminate"))
  end

  def disabled_item
    render(CheckboxesComponent.new(form:, method: :favorite_fruits, collection: self.class.fruit_options, item_value_method: :value, item_label_method: :label, item_states: {"orange" => :disabled}, instance_key: "disabled_item"))
  end

  def mixed_states
    render(CheckboxesComponent.new(form:, method: :favorite_fruits, collection: self.class.fruit_options, item_value_method: :value, item_label_method: :label, item_states: {"orange" => :indeterminate, "apple" => :disabled}, instance_key: "mixed_states"))
  end

  def mixed_states_with_error_and_warning
    custom_model = TestModel.new
    custom_model.valid?
    render(CheckboxesComponent.new(form: form(model: custom_model), method: :favorite_fruits, collection: self.class.fruit_options, item_value_method: :value, item_label_method: :label, warning_message: "Message goes here.", item_states: {"orange" => :indeterminate, "apple" => :disabled}, instance_key: "mixed_states_with_error_and_warning"))
  end
  # @!endgroup

  # @!group Small
  def small_default
    render(CheckboxesComponent.new(form:, method: :favorite_fruits, collection: self.class.fruit_options, item_value_method: :value, item_label_method: :label, small: true, instance_key: "small_default"))
  end

  def small_prefilled
    custom_model = TestModel.new(favorite_fruits: ["apple", "orange"])
    render(CheckboxesComponent.new(form: form(model: custom_model), method: :favorite_fruits, collection: self.class.fruit_options, item_value_method: :value, item_label_method: :label, small: true, instance_key: "small_prefilled"))
  end

  def small_with_error
    custom_model = TestModel.new
    custom_model.valid?
    render(CheckboxesComponent.new(form: form(model: custom_model), method: :favorite_fruits, collection: self.class.fruit_options, item_value_method: :value, item_label_method: :label, small: true, instance_key: "small_with_error"))
  end

  def small_with_warning
    render(CheckboxesComponent.new(form:, method: :favorite_fruits, collection: self.class.fruit_options, item_value_method: :value, item_label_method: :label, small: true, warning_message: "Message goes here.", instance_key: "small_with_warning"))
  end

  def small_indeterminate
    render(CheckboxesComponent.new(form:, method: :favorite_fruits, collection: self.class.fruit_options, item_value_method: :value, item_label_method: :label, small: true, item_states: {"orange" => :indeterminate}, instance_key: "small_indeterminate"))
  end

  def small_disabled_item
    render(CheckboxesComponent.new(form:, method: :favorite_fruits, collection: self.class.fruit_options, item_value_method: :value, item_label_method: :label, small: true, item_states: {"orange" => :disabled}, instance_key: "small_disabled_item"))
  end

  def small_mixed_states
    render(CheckboxesComponent.new(form:, method: :favorite_fruits, collection: self.class.fruit_options, item_value_method: :value, item_label_method: :label, small: true, item_states: {"orange" => :indeterminate, "apple" => :disabled}, instance_key: "small_mixed_states"))
  end

  def small_mixed_states_with_error_and_warning
    custom_model = TestModel.new
    custom_model.valid?
    render(CheckboxesComponent.new(form: form(model: custom_model), method: :favorite_fruits, collection: self.class.fruit_options, item_value_method: :value, item_label_method: :label, small: true, warning_message: "Message goes here.", item_states: {"orange" => :indeterminate, "apple" => :disabled}, instance_key: "small_mixed_states_with_error_and_warning"))
  end
  # @!endgroup
end
