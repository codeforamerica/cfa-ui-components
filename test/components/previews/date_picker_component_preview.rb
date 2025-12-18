class DatePickerComponentPreview < FormComponentPreview
  include ActionView::Helpers::DateHelper
  def default
    render DatePickerComponent.new(form: form,
                             method: :my_date
                          )
  end
  def with_labels
    render DatePickerComponent.new(form: form,
                             method: :my_date,
                             prompt: { day: "Select day", month: "Select month", year: "Select year" }
                          )
  end
  def custom_year_range
    render DatePickerComponent.new(form: form,
                             method: :my_date,
                             start_year: Date.current.year - 20,
                             end_year: Date.current.year + 50
                          )
  end
end
