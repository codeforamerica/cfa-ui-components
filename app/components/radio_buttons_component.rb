# frozen_string_literal: true

class RadioButtonsComponent < AttributeBoundFormElementComponent
  def initialize(form:, method:, collection:, item_value_method:, item_label_method:, layout: :vertical)
    super(form: form, method: method)
    @collection = collection
    @item_value_method = item_value_method
    @item_label_method = item_label_method
    @layout =
      case layout
      when :horizontal
        "flex items-start gap-4"
      when :vertical
        "space-y-4"
      else
        raise ArgumentError("Invalid layout")
      end
  end
end
