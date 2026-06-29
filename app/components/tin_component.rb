# frozen_string_literal: true

class TinComponent < AttributeBoundFormElementComponent
  # When +confirmation_method+ is given, a second, paired input is rendered so
  # the value can be confirmed (e.g. a TIN and its confirmation).
  #
  # When the bound attribute already holds a value (i.e. it was previously saved)
  # the component renders an obfuscated summary (•••-••-1234) with an "Edit"
  # button instead of pre-filling the raw value. Choosing "Edit" reveals the
  # empty input(s); "Cancel" restores the obfuscated view. The raw value is never
  # written into an input, so it can't be read from the DOM or revealed with the
  # show toggle on revisit.
  def initialize(form:, method:, label:, help_text: nil, optional: false, input_attrs: {},
    confirmation_method: nil, confirmation_label: nil, confirmation_help_text: nil)
    super(form:, method:, input_attrs:)
    @label = label
    @help_text = help_text
    @optional = optional
    @confirmation_method = confirmation_method
    @confirmation_label = confirmation_label
    @confirmation_help_text = confirmation_help_text
  end

  private

  def confirmation?
    @confirmation_method.present?
  end

  # A field's label, with the "(optional)" marker appended when applicable.
  def field_label(field)
    return field[:label] unless @optional
    safe_join([field[:label], " ", tag.span("(#{I18n.t("cfaui.optional")})", class: "font-normal")])
  end

  # The set of inputs to render, in order. Each describes one text field.
  def fields
    list = [{method: @method, label: @label, help_text: @help_text, primary: true}]
    if confirmation?
      list << {method: @confirmation_method, label: @confirmation_label, help_text: @confirmation_help_text, primary: false}
    end
    list
  end

  # Digits-only of the saved value, used only to derive the obfuscated summary.
  def saved_digits
    current_value.to_s.gsub(/\D/, "")
  end

  # A value was previously saved, so the obfuscated view + Edit toggle apply.
  def saved_value?
    saved_digits.present?
  end

  def last_four
    saved_digits.last(4)
  end

  def masked_value
    "•••-••-#{last_four}"
  end

  # Whether the most recent submit left validation errors on either field.
  def errors?
    fields.any? { |field| @form.object.errors[field[:method]].any? }
  end

  # Start in edit mode when there is nothing saved yet (first entry) or when the
  # last submit failed validation, so the submitted values stay visible for
  # correction. Otherwise (a clean revisit) start with the obfuscated view.
  def editing_initially?
    !saved_value? || errors?
  end

  # Attributes for a field's text input. On a clean revisit the input is rendered
  # empty (so the raw value never enters the DOM) and disabled (so it isn't
  # submitted, leaving the saved value untouched). The show toggle and disabled
  # state are bound to Alpine when the obfuscated view is in play.
  def text_field_options(field)
    method = field[:method]
    errored = @form.object.errors[method].any?

    options = {
      type: "text",
      inputmode: "numeric",
      autocomplete: "off",
      class: "w-full max-w-sm",
      placeholder: "000-00-0000",
      "x-ref": "input",
      "x-mask": "999-99-9999",
      "x-bind:style": "show ? '' : '-webkit-text-security: disc;'",
      "data-tin-input": ""
    }
    options["aria-required"] = "true" unless @optional
    options["aria-invalid"] = "true" if errored

    described_by = []
    described_by << @form.field_id(method, :help) if field[:help_text].present?
    described_by << @form.field_id(method, :error) if errored
    options["aria-describedby"] = described_by.join(" ") if described_by.any?

    # Don't pre-fill the saved value on a clean revisit.
    options[:value] = "" unless editing_initially?

    if saved_value?
      options["x-bind:disabled"] = "!editing"
      options[:disabled] = true unless editing_initially?
    end

    # Only the primary field merges caller-supplied input_attrs.
    field[:primary] ? field_attrs(**options) : options
  end
end
