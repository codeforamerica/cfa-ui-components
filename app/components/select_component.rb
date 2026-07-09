# frozen_string_literal: true

class SelectComponent < AttributeBoundFormElementComponent
  def initialize(form:, method:, label:, collection:, item_value_method:, item_label_method:, help_text: nil, optional: false, disabled: false, css_class: nil, input_attrs: {})
    super(form:, method:, css_class:, input_attrs:)
    @label = label
    @help_text = help_text
    @collection = collection
    @item_value_method = item_value_method
    @item_label_method = item_label_method
    @optional = optional
    @disabled = disabled
  end

  private

  def options
    @options ||= begin
      mapped_options = @collection.map do |item|
        {
          label: item.public_send(@item_label_method).to_s,
          value: item.public_send(@item_value_method).to_s
        }
      end

      @optional ? [{label: placeholder_label, value: ""}, *mapped_options] : mapped_options
    end
  end

  def alpine_opts
    {
      options:,
      value: current_value,
      label: current_label,
      activeIndex: initial_active_index,
      disabled: @disabled,
      buttonId: input_id,
      listboxId: "#{input_id}-listbox"
    }.to_json
  end

  def placeholder_label
    I18n.t("cfaui.select.placeholder")
  end

  def current_label
    selected = options.find { |option| option[:value] == current_value.to_s }
    selected&.dig(:label) || placeholder_label
  end

  def initial_active_index
    options.find_index { |option| option[:value] == current_value.to_s } || -1
  end

  def input_id
    "#{@form.object_name}_#{@method}"
  end
end
