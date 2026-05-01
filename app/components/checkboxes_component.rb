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

  private

  def has_error?
    @form.object.errors[@method].any?
  end

  def has_warning?
    @warning_message.present? && !has_error?
  end

  def box_classes
    @small ? "h-4 w-4" : "h-6 w-6"
  end

  def icon_size
    @small ? 16 : 24
  end

  def border_class
    return "border-2 border-border-error" if has_error?
    return "border-2 border-border-warning" if has_warning?
    "border checked:border-2 disabled:border-border-disabled border-border-default"
  end

  def store_key
    suffix = @unique_id ? "_#{@unique_id}" : ""
    "#{@method}#{suffix}"
  end
end
