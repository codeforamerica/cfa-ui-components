# frozen_string_literal: true

class DropdownComponent < AttributeBoundFormElementComponent
  def initialize(form:, method:, collection:, item_value_method:, item_label_method:, required: false)
    super(form: form, method: method)
    @collection = collection
    @item_value_method = item_value_method
    @item_label_method = item_label_method
    @required = required
  end

  private

  def required_class
    @required ? "required" : ""
  end
end
