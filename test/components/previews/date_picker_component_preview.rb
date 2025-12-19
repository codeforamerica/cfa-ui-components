class DatePickerComponentPreview < FormComponentPreview
  include ActionView::Helpers::DateHelper
  def default
    render DatePickerComponent.new(form: form,
                             method: :my_date
                          )
  end
  def blank
    render DatePickerComponent.new(form: form,
                             method: :my_date,
                             include_blank: true
                          )
  end
  def with_labels
    render DatePickerComponent.new(form: form,
                             method: :my_date,
                             prompt: { day: "Select day", month: "Select month", year: "Select year" }
                          )
  end

  def with_error
    custom_model = TestModel.new
    custom_model.valid?
    render DatePickerComponent.new(form: form(model: custom_model),
                             method: :my_date,
                             include_blank: true
                          )
  end

  def with_pre_filled_values
    custom_model = TestModel.new(my_date: Date.today - 10.years)
    custom_model.valid?
    render DatePickerComponent.new(form: form(model: custom_model),
                             method: :my_date,
                          )
  end

  def custom_year_range
    render DatePickerComponent.new(form: form,
                             method: :my_date,
                             start_year: Date.current.year - 30,
                             end_year: Date.current.year + 50
                          )
  end
end
