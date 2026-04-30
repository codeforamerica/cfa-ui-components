# frozen_string_literal: true

class CheckboxesComponent < AttributeBoundFormElementComponent
  def initialize(form:, method:, collection:, item_value_method:, item_label_method:, small: false, warning_message: nil, indeterminate: [], unique_id: nil)
    super(form:, method:)
    @collection = collection
    @item_value_method = item_value_method
    @item_label_method = item_label_method
    @small = small
    @warning_message = warning_message
    @indeterminate = Array(indeterminate).map(&:to_s)
    @unique_id = unique_id
  end
end
