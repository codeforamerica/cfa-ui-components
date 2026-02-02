class DatePickerComponentPreview < FormComponentPreview
  include ActionView::Helpers::DateHelper
  def default
    render DatePickerComponent.new(form: form,
                             method: :my_date,
                             label: "Date Of Birth",
                             label_day: "Day",
                             label_month: "Month",
                             label_month_select: "- Select -",
                             label_year: "Year",

                          )
  end

  def with_helper_text
    render DatePickerComponent.new(form: form,
                             method: :my_date,
                             label: "Date Of Birth",
                             label_day: "Day",
                             label_month: "Month",
                             label_month_select: "- Select -",
                             label_year: "Year",
                             helper_text: "For example: August 28 1986"

                          )
  end

  def with_error
    custom_model = TestModel.new
    custom_model.valid?
       render DatePickerComponent.new(form: form(model: custom_model),
      method: :my_date,
      label: "Date Of Birth",
      label_day: "Day",
      label_month: "Month",
      label_month_select: "- Select -",
      label_year: "Year",
      helper_text: "For example: August 28 1986"

    )
  end

  def with_pre_filled_values
    custom_model = TestModel.new(my_date: Date.today - 10.years)
    custom_model.valid?
    render DatePickerComponent.new(form: form(model: custom_model),
      method: :my_date,
      label: "Date Of Birth",
      label_day: "Day",
      label_month: "Month",
      label_month_select: "- Select -",
      label_year: "Year",
      helper_text: "For example: August 28 1986"
    )
  end
end
