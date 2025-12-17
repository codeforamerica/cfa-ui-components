# frozen_string_literal: true

class DatePickerComponent < ViewComponent::Base
  def initialize(
    name: nil,
    form: nil,
    method: nil,
    selected: nil,
    start_year: Date.current.year - 100,
    end_year: Date.current.year,
    include_blank: true,
    order: %i[month day year],
    html_options: {},
    date_options: {}
  )
    @name          = name
    @form          = form
    @method        = method
    @selected      = coerce_date(selected)
    @start_year    = start_year
    @end_year      = end_year
    @include_blank = include_blank
    @order         = order
    @html_options  = html_options
    @date_options  = date_options
  end

  private

  def selected_value
    return @selected if @selected.present?
    return nil unless @form && @method

    value = @form.object&.public_send(@method) rescue nil
    coerce_date(value)
  end

  def prefix_name
    return @name if @name.present?
    return nil unless @form && @method

    # Example: "user[birthdate]"
    "#{@form.object_name}[#{@method}]"
  end

  def coerce_date(value)
    return value if value.is_a?(Date)
    return value.to_date if value.respond_to?(:to_date)
    return nil if value.blank?

    Date.parse(value.to_s)
  rescue ArgumentError
    nil
  end
end
