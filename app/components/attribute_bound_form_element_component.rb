class AttributeBoundFormElementComponent < BaseComponent
  def initialize(form:, method:)
    @form = form
    @method = method
  end

  private

  def current_value
    @form.object.send @method
  end
end
