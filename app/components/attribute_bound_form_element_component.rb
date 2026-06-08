class AttributeBoundFormElementComponent < BaseComponent
  def initialize(form:, method:, css_class: nil, input_attrs: {})
    @form = form
    @method = method
    @css_class = css_class
    @input_attrs = input_attrs
  end

  private

  def current_value
    @form.object.send @method
  end
end
