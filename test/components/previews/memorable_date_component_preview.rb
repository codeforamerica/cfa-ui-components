class MemorableDateComponentPreview < FormComponentPreview
  include ActionView::Helpers::DateHelper

  def default
    render MemorableDateComponent.new(form:,
      method: :my_date,
      label: I18n.t("date_of_birth"))
  end

  def with_helper_text
    render MemorableDateComponent.new(form:,
      method: :my_date,
      label: I18n.t("date_of_birth"),
      helper_text: I18n.t("date_helper_text"))
  end

  def with_error
    custom_model = TestModel.new
    custom_model.valid?
    render MemorableDateComponent.new(form: form(model: custom_model),
      method: :my_date,
      label: I18n.t("date_of_birth"),
      helper_text: I18n.t("date_helper_text"))
  end

  def with_pre_filled_values
    custom_model = TestModel.new(my_date: Date.today - 10.years)
    custom_model.valid?
    render MemorableDateComponent.new(form: form(model: custom_model),
      method: :my_date,
      label: I18n.t("date_of_birth"),
      helper_text: I18n.t("date_helper_text"))
  end
end
