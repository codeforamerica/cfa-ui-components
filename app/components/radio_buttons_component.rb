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

  private

  def has_error?
    @form.object.errors[@method].any?
  end

  def has_warning?
    @warning_message.present?
  end

  def icon_size
    @small ? 16 : 24
  end

  def radio_classes
    classes = ["cfa-radio"]
    classes << "cfa-radio--small" if @small
    classes << "cfa-radio--error" if has_error?
    classes << "cfa-radio--warning" if has_warning? && !has_error?
    classes.join(" ")
  end

  def store_key
    suffix = @unique_id ? "_#{@unique_id}" : @unique_alpine_store_key.to_s
    "#{@method}#{suffix}"
  end
end
