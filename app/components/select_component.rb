# frozen_string_literal: true

class SelectComponent < AttributeBoundFormElementComponent
  def initialize(form:, method:, label:, collection:, item_value_method:, item_label_method:, help_text: nil, optional: false)
    super(form:, method:)
    @label = label
    @help_text = help_text
    @collection = collection
    @item_value_method = item_value_method
    @item_label_method = item_label_method
    @optional = optional
  end
end
