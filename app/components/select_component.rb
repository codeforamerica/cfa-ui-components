# frozen_string_literal: true

class SelectComponent < AttributeBoundFormElementComponent
  def initialize(form:, method:, label:, collection:, item_value_method:, item_label_method:, help_text: nil, optional: false, disabled: false)
    super(form:, method:)
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
    @options ||= [
      {label: "- Select -", value: ""},
      *@collection.map do |item|
        {
          label: item.public_send(@item_label_method).to_s,
          value: item.public_send(@item_value_method).to_s
        }
      end
    ]
  end

  def options_json
    options.to_json
  end

  def current_value
    @form.object.public_send(@method).to_s
  end

  def current_label
    selected = options.find { |option| option[:value] == current_value }
    selected&.dig(:label) || "- Select -"
  end

  def initial_active_index
    index = options.find_index { |option| option[:value] == current_value }
    index || 0
  end
end
