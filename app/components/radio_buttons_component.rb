# frozen_string_literal: true

class RadioButtonsComponent < AttributeBoundFormElementComponent
  def initialize(form:, method:, collection:, item_value_method:, item_label_method:, unique_alpine_store_key: "", layout: :vertical, small: false, warning_message: nil, unique_id: nil, legend: nil)
    super(form:, method:)
    @collection = collection
    @item_value_method = item_value_method
    @item_label_method = item_label_method
    @unique_alpine_store_key = unique_alpine_store_key
    @small = small
    @warning_message = warning_message
    @unique_id = unique_id
    @legend = legend
    @layout =
      case layout
      when :horizontal
        "flex items-center gap-cfa-lg"
      when :vertical
        "space-y-cfa-med"
      else
        raise ArgumentError.new("Invalid layout")
      end
  end
end
