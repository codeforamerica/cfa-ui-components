class MemorableDateComponentPreview < FormComponentPreview
  include ActionView::Helpers::DateHelper

  # The day/month/year/placeholder sub-labels are intentionally omitted so the
  # component falls back to its localized defaults and the lang display toggle
  # actually switches them between English and Spanish.
  def default
    render MemorableDateComponent.new(form:,
      method: :my_date,
      label: "Date Of Birth")
  end

  def with_helper_text
    render MemorableDateComponent.new(form:,
      method: :my_date,
      label: "Date Of Birth",
      helper_text: "For example: August 28 1986")
  end

  def with_error
    custom_model = TestModel.new
    custom_model.valid?
    render MemorableDateComponent.new(form: form(model: custom_model),
      method: :my_date,
      label: "Date Of Birth",
      helper_text: "For example: August 28 1986")
  end

  def with_pre_filled_values
    custom_model = TestModel.new(my_date: Date.today - 10.years)
    custom_model.valid?
    render MemorableDateComponent.new(form: form(model: custom_model),
      method: :my_date,
      label: "Date Of Birth",
      helper_text: "For example: August 28 1986")
  end
end
