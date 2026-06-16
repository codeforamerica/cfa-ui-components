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

  # Merge the caller's `input_attrs` onto a field's default attributes.
  # Caller-supplied attrs win, except `:class` and `:aria`, which are combined
  # with the component's defaults: `:class` is concatenated (and de-duped) and
  # `:aria` is shallow-merged, so passing `input_attrs: { class: "..." }` or
  # `input_attrs: { aria: { ... } }` augments rather than clobbers the field's
  # own styling and accessibility attributes.
  def field_attrs(**defaults)
    attrs = defaults.merge(@input_attrs)
    attrs[:class] = class_names(defaults[:class], @input_attrs[:class])
    if defaults[:aria] || @input_attrs[:aria]
      attrs[:aria] = (defaults[:aria] || {}).merge(@input_attrs[:aria] || {})
    end
    attrs
  end
end
