# frozen_string_literal: true

class CheckboxesComponent < AttributeBoundFormElementComponent
  ALLOWED_ITEM_STATES = [:disabled, :indeterminate].freeze

  def initialize(form:, method:, collection:, item_value_method:, item_label_method:, small: false, warning_message: nil, item_states: {}, unique_id: nil)
    super(form:, method:)
    @collection = collection
    @item_value_method = item_value_method
    @item_label_method = item_label_method
    @small = small
    @warning_message = warning_message
    @item_states = item_states.transform_keys(&:to_s).transform_values(&:to_sym)
    invalid = @item_states.values - ALLOWED_ITEM_STATES
    raise ArgumentError, "Unknown item_states: #{invalid.inspect}. Allowed: #{ALLOWED_ITEM_STATES.inspect}" if invalid.any?
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

  def state_for(value)
    @item_states[value.to_s]
  end

  def store_key
    suffix = @unique_id ? "_#{@unique_id}" : ""
    "#{@method}#{suffix}"
  end
end
