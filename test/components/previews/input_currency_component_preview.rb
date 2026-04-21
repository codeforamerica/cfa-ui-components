class InputCurrencyComponentPreview <  FormComponentPreview
  def default
    render(InputCurrencyComponent.new(form: form, method: :my_number, label: I18n.t(:my_number), min: 0))
  end
  def required
    render(InputCurrencyComponent.new(form: form, method: :my_number, label: I18n.t(:my_number), min: 0, required: true))
  end

  def with_helper_text
    render(InputCurrencyComponent.new(form: form, method: :my_number, label: I18n.t(:my_number), help_text: "pick a number", min: 0))
  end

  def with_error
    custom_model = TestModel.new
    custom_model.valid?
    puts "custom_model.valid? #{custom_model.valid?}"
    render(InputCurrencyComponent.new(form: form(model: custom_model), method: :my_number, label: I18n.t(:my_number)))
  end
end
