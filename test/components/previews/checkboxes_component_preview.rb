class CheckboxesComponentPreview < FormComponentPreview
  def default
    render(CheckboxesComponent.new(form:, method: :favorite_fruits, collection: self.class.fruit_options, item_value_method: :value, item_label_method: :label))
  end

  def prefilled
    custom_model = TestModel.new(favorite_fruits: ["apple", "orange"])
    render(CheckboxesComponent.new(form: form(model: custom_model), method: :favorite_fruits, collection: self.class.fruit_options, item_value_method: :value, item_label_method: :label))
  end

  def with_error
    custom_model = TestModel.new
    custom_model.valid?
    render(CheckboxesComponent.new(form: form(model: custom_model), method: :favorite_fruits, collection: self.class.fruit_options, item_value_method: :value, item_label_method: :label))
  end
end
