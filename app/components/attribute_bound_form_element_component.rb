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
  # Caller-supplied attrs win, except `:class`, which is combined with the
  # component's base classes so passing `input_attrs: { class: "..." }`
  # augments rather than clobbers the field's own styling.
  def field_attrs(**defaults)
    defaults.merge(@input_attrs).merge(
      class: class_names(defaults[:class], @input_attrs[:class])
    )
  end
end
