class CfaFormBuilder < ActionView::Helpers::FormBuilder
  COMPONENTS = {
    text: InputComponent,
    currency: InputCurrencyComponent,
    select: SelectComponent,
    combobox: ComboboxComponent,
    tin: TinComponent,
    checkbox: SingleCheckboxComponent,
    radios: RadioButtonsComponent,
    date: MemorableDateComponent
  }.freeze

  def input(method, as: :text, **opts)
    component = COMPONENTS.fetch(as) do
      raise ArgumentError, "Unknown CfaFormBuilder component: #{as}. Valid: #{COMPONENTS.keys}"
    end
    opts[:form] = self
    opts[:method] = method
    opts[:optional] = !required?(method) unless opts.key?(:optional)
    @template.render component.new(**opts)
  end

  def required?(method)
    klass = object&.class
    return true unless klass.respond_to?(:validators_on)
    klass.validators_on(method).any? { |v| v.kind == :presence || v.kind == :acceptance }
  end
end
