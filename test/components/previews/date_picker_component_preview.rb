class DatePickerComponentPreview < FormComponentPreview
  def default
    render DatePickerComponent.new(
      name: "user[birthdate]",
      selected: Date.new(1992, 6, 15)
    )
  end

  def blank
    render DatePickerComponent.new(
      name: "user[birthdate]",
      selected: nil,
      include_blank: true
    )
  end

  def custom_year_range
    render DatePickerComponent.new(
      name: "user[birthdate]",
      selected: Date.new(2001, 1, 1),
      start_year: 1980,
      end_year: Date.current.year + 5
    )
  end
end
