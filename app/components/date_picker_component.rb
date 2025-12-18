# frozen_string_literal: true

class DatePickerComponent < ViewComponent::Base
  def initialize(
    name: nil,
    form: nil,
    method: nil,
    selected: nil,
    start_year: Date.current.year - 100,
    end_year: Date.current.year,
    include_blank: false,
    order: %i[month day year],
    html_options: {},
    date_options: {}
  )
    @form          = form
    @method        = method
    @start_year    = start_year
    @end_year      = end_year
    @include_blank = include_blank
    @order         = order
    @html_options  = html_options
    @date_options  = date_options
  end
end
