class InputCurrencyComponentPreview < FormComponentPreview
  def default
    render(InputCurrencyComponent.new(form:, method: :my_number, label: I18n.t(:my_number), input_attrs: {min: 0}))
  end

  def optional
    render(InputCurrencyComponent.new(form:, method: :my_number, label: I18n.t(:my_number), input_attrs: {min: 0}, optional: true))
  end

  def with_helper_text
    render(InputCurrencyComponent.new(form:, method: :my_number, label: I18n.t(:my_number), help_text: "pick a number", input_attrs: {min: 0}))
  end

  def submission_demo
  end

  def with_error
    custom_model = TestModel.new
    custom_model.valid?
    puts "custom_model.valid? #{custom_model.valid?}"
    render(InputCurrencyComponent.new(form: form(model: custom_model), method: :my_number, label: I18n.t(:my_number)))
  end
end
