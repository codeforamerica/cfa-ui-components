# frozen_string_literal: true

class MemorableDateComponent < AttributeBoundFormElementComponent
  def initialize(form:, method:, label:, label_day: nil, label_month: nil, label_month_select: nil, label_year: nil, placeholder_day: nil, placeholder_year: nil, helper_text: nil, aria_labelledby: nil, css_class: nil, input_attrs: {})
    raise ArgumentError, "must provide a non-blank label: or aria_labelledby:" if label.blank? && aria_labelledby.nil?
    if input_attrs.key?(:id)
      raise ArgumentError, "MemorableDateComponent forwards input_attrs to the " \
        "day/month/year fields, so a single :id would collide across them. Omit it."
    end
    super(form:, method:, css_class:, input_attrs:)
    @label = label
    # The day/month/year sub-labels are identical across consumers, so they
    # default to the library's own localized strings; callers may still override.
    @label_day = label_day || I18n.t("cfaui.memorable_date.day")
    @label_month = label_month || I18n.t("cfaui.memorable_date.month")
    @label_month_select = label_month_select || I18n.t("cfaui.memorable_date.month_select")
    @label_year = label_year || I18n.t("cfaui.memorable_date.year")
    @placeholder_day = placeholder_day || I18n.t("cfaui.memorable_date.placeholder_day")
    @placeholder_year = placeholder_year || I18n.t("cfaui.memorable_date.placeholder_year")
    @helper_text = helper_text
    @aria_labelledby = aria_labelledby
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
    # I18n.t returns the locale's month_names array ([nil, "January", ...]);
    # Active Support ships English, and es.yml supplies the Spanish names.
    [[@label_month_select, ""]] +
      I18n.t("date.month_names").compact.each_with_index.map { |m, i| [m, i + 1] }
  end

  def month_alpine_opts
    {
      options: month_options.map { |label, value| {label:, value: value.to_s} },
      value: month_value.to_s,
      label: initial_month_label,
      activeIndex: initial_active_index,
      buttonId: input_id(2),
      listboxId: "#{input_id(2)}-listbox"
    }.to_json
  end

  def initial_month_label
    month_options.find { |_, value| value.to_s == month_value.to_s }&.first || @label_month_select
  end

  def initial_active_index
    month_options.find_index { |_, value| value.to_s == month_value.to_s } || 0
  end

  def raw_date_parts
    raw = @form.object.attributes_before_type_cast[@method.to_s]
    return raw if raw.is_a?(Hash)
    nil
  end

  def raw_date_part(part)
    raw_date_parts&.[](part) || raw_date_parts&.[](part.to_s)
  end

  def month_value
    raw_date_part(2).presence || date&.month
  end

  def day_value
    raw_date_part(3).presence || date&.day
  end

  def year_value
    raw_date_part(1).presence || date&.year
  end
end
