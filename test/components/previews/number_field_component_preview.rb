class NumberFieldComponentPreview <  FormComponentPreview
  def default
    render(NumberFieldComponent.new(form: form, method: :my_number, label: I18n.t(:my_number), min_num: 0, max_num: 1000))
  end
  def required
    render(NumberFieldComponent.new(form: form, method: :my_number, label: I18n.t(:my_number), min_num: 0, max_num: 1000, required: true))
  end

  def with_helper_text
    render(NumberFieldComponent.new(form: form, method: :my_number, label: I18n.t(:my_number), help_text: "pick a number", min_num: 0, max_num: 1000))
  end

  def with_error
    custom_model = TestModel.new
    custom_model.valid?
    puts "custom_model.valid? #{custom_model.valid?}"
    render(NumberFieldComponent.new(form: form(model: custom_model), method: :my_number, label: I18n.t(:my_number), max_num: 1000))
  end
end
