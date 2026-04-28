# frozen_string_literal: true

class ComboboxComponent < AttributeBoundFormElementComponent
  def initialize(form:, method:, label:, collection:, item_value_method:, item_label_method:, item_disabled_method: nil, help_text: nil, required: false)
    super(form:, method:)
    @label = label
    @help_text = help_text
    @collection = collection
    @item_value_method = item_value_method
    @item_label_method = item_label_method
    @item_disabled_method = item_disabled_method
    @required = required
  end

  def disabled?(item)
    @item_disabled_method && item.send(@item_disabled_method)
  end

  def disabled_values
    return [] unless @item_disabled_method
    @collection.select { |o| disabled?(o) }.map { |o| o.send(@item_value_method).to_s }
  end
end
