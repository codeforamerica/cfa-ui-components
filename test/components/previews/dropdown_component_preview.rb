class DropdownComponentPreview < FormComponentPreview
  def default
    render(DropdownComponent.new(form: form, method: :favorite_fruits, collection: self.class.fruit_options, item_value_method: :value, item_label_method: :label))
  end

  def prefilled
    custom_model = TestModel.new(favorite_fruits: "apple")
    render(DropdownComponent.new(form: form(model: custom_model), method: :favorite_fruits, collection: self.class.fruit_options, item_value_method: :value, item_label_method: :label))
  end

  def with_errors
    custom_model = TestModel.new
    custom_model.valid?
    render(DropdownComponent.new(form: form(model: custom_model), method: :favorite_fruits, collection: self.class.fruit_options, item_value_method: :value, item_label_method: :label))
  end

  def required
    render(DropdownComponent.new(form: form, method: :favorite_fruits, collection: self.class.fruit_options, item_value_method: :value, item_label_method: :label, required: true))
  end
end
