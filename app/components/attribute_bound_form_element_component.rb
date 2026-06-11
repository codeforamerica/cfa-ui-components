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

  # DOM ids of this field's description elements, so inputs can point at them
  # via aria-describedby. Each id is only present in the DOM when its element is.
  def error_dom_id
    @form.field_id(@method, :error)
  end

  def help_dom_id
    @form.field_id(@method, :help)
  end

  def warning_dom_id
    @form.field_id(@method, :warning)
  end

  # Space-separated aria-describedby value listing whichever descriptions are
  # present, in DOM/reading order (help text, error, warning). nil when none.
  def described_by_value(help: false, warning: false)
    ids = []
    ids << help_dom_id if help
    ids << error_dom_id if field_has_error?
    ids << warning_dom_id if warning
    ids.join(" ") if ids.any?
  end

  # Splat onto a single input widget: marks it invalid on error and associates
  # it with its description(s). Empty (no-op) when there's nothing to add.
  def aria_field_attrs(described_by_help: false)
    attrs = {}
    attrs["aria-invalid"] = "true" if field_has_error?
    value = described_by_value(help: described_by_help)
    attrs["aria-describedby"] = value if value
    attrs
  end
end
