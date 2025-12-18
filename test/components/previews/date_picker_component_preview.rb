class DatePickerComponentPreview < FormComponentPreview
  include ActionView::Helpers::DateHelper
  def default
    render DatePickerComponent.new(form: form,
                             method: :my_date,
                             html_options: { class: "date-select" }
                          )
  end

  def custom_year_range
    render DatePickerComponent.new(form: form,
                             method: :my_date,
                             start_year: Date.current.year - 20,
                             end_year: Date.current.year + 50,
                             html_options: { class: "date-select" }
                          )
  end
end
