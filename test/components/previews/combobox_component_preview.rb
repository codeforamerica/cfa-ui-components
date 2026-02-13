class ComboboxComponentPreview < FormComponentPreview
  def default
    render(ComboboxComponent.new(form: form, method: :favorite_fruits, label: I18n.t(:favorite_fruits), collection: self.class.fruit_options, item_value_method: :value, item_label_method: :label))
  end

  def with_helper_text
    render(ComboboxComponent.new(form: form, method: :favorite_fruits, label: I18n.t(:favorite_fruits), help_text: I18n.t(:fruit_help_text), collection: self.class.fruit_options, item_value_method: :value, item_label_method: :label))
  end

  # def with_error
  #   custom_model = TestModel.new
  #   custom_model.valid?
  #   render(CheckboxesComponent.new(form: form(model: custom_model), method: :favorite_fruits, collection: self.class.fruit_options, item_value_method: :value, item_label_method: :label))
  # end
end
