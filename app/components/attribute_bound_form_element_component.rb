class AttributeBoundFormElementComponent < BaseComponent
  def initialize(form:, method:)
    @form = form
    @method = method
  end

  private

  def current_value
    @form.object.send @method
  end

  def field_has_error?
    @form.object.errors[@method].any?
  end

  # DOM id of this field's FormErrorsComponent message, so inputs can point at
  # it via aria-describedby. Only present in the DOM when the field has an error.
  def error_dom_id
    @form.field_id(@method, :error)
  end

  # Splat onto a single input widget to mark it invalid and associate it with
  # its error message. Empty (no-op) when the field is valid.
  def aria_error_attrs
    return {} unless field_has_error?
    {"aria-invalid" => "true", "aria-describedby" => error_dom_id}
  end
end
