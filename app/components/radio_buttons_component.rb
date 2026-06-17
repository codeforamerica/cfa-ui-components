# frozen_string_literal: true

class RadioButtonsComponent < AttributeBoundFormElementComponent
  # scope namespaces both the Alpine store key and the input id/label-for,
  # so multiple instances of this component can coexist on a single page.
  def initialize(form:, method:, collection:, item_value_method:, item_label_method:, legend: nil, aria_labelledby: nil, scope: nil, layout: :vertical, small: false, bordered: false, warning_message: nil, css_class: nil)
    raise ArgumentError, "must provide legend: or aria_labelledby:" if legend.nil? && aria_labelledby.nil?
    super(form:, method:, css_class:)
    @collection = collection
    @item_value_method = item_value_method
    @item_label_method = item_label_method
    @scope = scope
    @small = small
    @bordered = bordered
    @warning_message = warning_message
    @legend = legend
    @aria_labelledby = aria_labelledby
    @layout =
      case layout
      when :horizontal
        "flex items-center gap-cfa-lg"
      when :vertical
        "cfa-stack-med"
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
    class_names(
      "cfa-radio",
      "cfa-radio--small": @small,
      "cfa-radio--error": has_error?,
      "cfa-radio--warning": has_warning? && !has_error?
    )
  end

  def store_key
    suffix = @scope.present? ? "_#{@scope}" : ""
    "#{@method}#{suffix}"
  end
end
