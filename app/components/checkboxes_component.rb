# frozen_string_literal: true

class CheckboxesComponent < AttributeBoundFormElementComponent
  def initialize(form:, method:, collection:, item_value_method:, item_label_method:)
    super(form: form, method: method)
    @collection = collection
    @item_value_method = item_value_method
    @item_label_method = item_label_method
  end
end
