class CheckboxesComponentPreview < FormComponentPreview
  # @!group Default
  def default
    render(CheckboxesComponent.new(form:, method: :favorite_fruits, collection: self.class.fruit_options, item_value_method: :value, item_label_method: :label, scope: "default", legend: "What are your favorite fruits?"))
  end

  def prefilled
    custom_model = TestModel.new(favorite_fruits: ["apple", "orange"])
    render(CheckboxesComponent.new(form: form(model: custom_model), method: :favorite_fruits, collection: self.class.fruit_options, item_value_method: :value, item_label_method: :label, scope: "prefilled", legend: "What are your favorite fruits?"))
  end

  def with_error
    custom_model = TestModel.new
    custom_model.valid?
    render(CheckboxesComponent.new(form: form(model: custom_model), method: :favorite_fruits, collection: self.class.fruit_options, item_value_method: :value, item_label_method: :label, scope: "with_error", legend: "What are your favorite fruits?"))
  end

  def with_warning
    render(CheckboxesComponent.new(form:, method: :favorite_fruits, collection: self.class.fruit_options, item_value_method: :value, item_label_method: :label, warning_message: "Message goes here.", scope: "with_warning", legend: "What are your favorite fruits?"))
  end

  def indeterminate
    render(CheckboxesComponent.new(form:, method: :favorite_fruits, collection: self.class.fruit_options, item_value_method: :value, item_label_method: :label, item_states: {"orange" => :indeterminate}, scope: "indeterminate", legend: "What are your favorite fruits?"))
  end

  def disabled_item
    render(CheckboxesComponent.new(form:, method: :favorite_fruits, collection: self.class.fruit_options, item_value_method: :value, item_label_method: :label, item_states: {"orange" => :disabled}, scope: "disabled_item", legend: "What are your favorite fruits?"))
  end

  def mixed_states
    render(CheckboxesComponent.new(form:, method: :favorite_fruits, collection: self.class.fruit_options, item_value_method: :value, item_label_method: :label, item_states: {"orange" => :indeterminate, "apple" => :disabled}, scope: "mixed_states", legend: "What are your favorite fruits?"))
  end

  def mixed_states_with_error_and_warning
    custom_model = TestModel.new
    custom_model.valid?
    render(CheckboxesComponent.new(form: form(model: custom_model), method: :favorite_fruits, collection: self.class.fruit_options, item_value_method: :value, item_label_method: :label, warning_message: "Message goes here.", item_states: {"orange" => :indeterminate, "apple" => :disabled}, scope: "mixed_states_with_error_and_warning", legend: "What are your favorite fruits?"))
  end
  # @!endgroup

  # @!group Small
  def small_default
    render(CheckboxesComponent.new(form:, method: :favorite_fruits, collection: self.class.fruit_options, item_value_method: :value, item_label_method: :label, small: true, scope: "small_default", legend: "What are your favorite fruits?"))
  end

  def small_prefilled
    custom_model = TestModel.new(favorite_fruits: ["apple", "orange"])
    render(CheckboxesComponent.new(form: form(model: custom_model), method: :favorite_fruits, collection: self.class.fruit_options, item_value_method: :value, item_label_method: :label, small: true, scope: "small_prefilled", legend: "What are your favorite fruits?"))
  end

  def small_with_error
    custom_model = TestModel.new
    custom_model.valid?
    render(CheckboxesComponent.new(form: form(model: custom_model), method: :favorite_fruits, collection: self.class.fruit_options, item_value_method: :value, item_label_method: :label, small: true, scope: "small_with_error", legend: "What are your favorite fruits?"))
  end

  def small_with_warning
    render(CheckboxesComponent.new(form:, method: :favorite_fruits, collection: self.class.fruit_options, item_value_method: :value, item_label_method: :label, small: true, warning_message: "Message goes here.", scope: "small_with_warning", legend: "What are your favorite fruits?"))
  end

  def small_indeterminate
    render(CheckboxesComponent.new(form:, method: :favorite_fruits, collection: self.class.fruit_options, item_value_method: :value, item_label_method: :label, small: true, item_states: {"orange" => :indeterminate}, scope: "small_indeterminate", legend: "What are your favorite fruits?"))
  end

  def small_disabled_item
    render(CheckboxesComponent.new(form:, method: :favorite_fruits, collection: self.class.fruit_options, item_value_method: :value, item_label_method: :label, small: true, item_states: {"orange" => :disabled}, scope: "small_disabled_item", legend: "What are your favorite fruits?"))
  end

  def small_mixed_states
    render(CheckboxesComponent.new(form:, method: :favorite_fruits, collection: self.class.fruit_options, item_value_method: :value, item_label_method: :label, small: true, item_states: {"orange" => :indeterminate, "apple" => :disabled}, scope: "small_mixed_states", legend: "What are your favorite fruits?"))
  end

  def small_mixed_states_with_error_and_warning
    custom_model = TestModel.new
    custom_model.valid?
    render(CheckboxesComponent.new(form: form(model: custom_model), method: :favorite_fruits, collection: self.class.fruit_options, item_value_method: :value, item_label_method: :label, small: true, warning_message: "Message goes here.", item_states: {"orange" => :indeterminate, "apple" => :disabled}, scope: "small_mixed_states_with_error_and_warning", legend: "What are your favorite fruits?"))
  end
  # @!endgroup
end
