class AttributeBoundFormElementComponent < BaseComponent
  def initialize(form:, method:, css_class: nil)
    @form = form
    @method = method
    @css_class = css_class
  end

  private

  def current_value
    @form.object.send @method
  end
end
