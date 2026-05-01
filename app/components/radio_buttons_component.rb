# frozen_string_literal: true

class RadioButtonsComponent < AttributeBoundFormElementComponent
  # instance_key namespaces both the Alpine store key and the input id/label-for,
  # so multiple instances of this component can coexist on a single page.
  def initialize(form:, method:, collection:, item_value_method:, item_label_method:, instance_key: nil, layout: :vertical, small: false, warning_message: nil, legend: nil)
    super(form:, method:)
    @collection = collection
    @item_value_method = item_value_method
    @item_label_method = item_label_method
    @instance_key = instance_key
    @small = small
    @warning_message = warning_message
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
    suffix = @instance_key.present? ? "_#{@instance_key}" : ""
    "#{@method}#{suffix}"
  end
end
