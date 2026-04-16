# frozen_string_literal: true

class RadioButtonsComponent < AttributeBoundFormElementComponent
  def initialize(form:, method:, collection:, item_value_method:, item_label_method:, unique_alpine_store_key: "", layout: :vertical)
    super(form: form, method: method)
    @collection = collection
    @item_value_method = item_value_method
    @item_label_method = item_label_method
    @unique_alpine_store_key = unique_alpine_store_key
    @layout =
      case layout
      when :horizontal
        "flex items-start gap-4"
      when :vertical
        "space-y-4"
      else
        raise ArgumentError.new("Invalid layout")
      end
  end
end
