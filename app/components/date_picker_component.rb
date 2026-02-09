# frozen_string_literal: true

class DatePickerComponent < AttributeBoundFormElementComponent
  def initialize(form:, method:, label:, label_day:, label_month:, label_month_select:, label_year:, helper_text: nil)
      super(form: form, method: method)
      @label     = label
      @label_day = label_day
      @label_month = label_month
      @label_month_select = label_month_select
      @label_year = label_year
      @helper_text = helper_text
  end

  private


  def date
    @form.object.public_send(@method)
  end

  def object_name
    @form.object_name
  end

  # Rails multiparam pieces: (1i)=year, (2i)=month, (3i)=day
  def param_name(part)
    "#{object_name}[#{@method}(#{part}i)]"
  end

  def input_id(part)
    "#{object_name}_#{@method}_#{part}i"
  end

  def month_options
    Date::MONTHNAMES.compact.each_with_index.map { |m, i| [ m, i + 1 ] }
  end

  def month_value = date&.month
  def day_value   = date&.day
  def year_value  = date&.year
end
