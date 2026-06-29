# frozen_string_literal: true

class InputComponent < AttributeBoundFormElementComponent
  # Leading bullets shown in the obfuscated summary (•••••1234). Fixed-width so
  # the true length of the saved value isn't leaked.
  MASK_PREFIX = "•••••"

  # When +obfuscate+ is true and the bound attribute already holds a value (i.e.
  # it was previously saved), the component renders an obfuscated summary
  # (•••••1234) with a "secondary small" Edit button instead of pre-filling the
  # raw value. Choosing Edit reveals the empty input(s); Cancel restores the
  # obfuscated view. The raw value is never written into an input, so it can't
  # be read from the DOM or resubmitted on a clean revisit.
  #
  # When +confirmation_method+ is given, a second paired input is rendered so
  # the value can be confirmed (e.g. a routing number and its confirmation).
  #
  # By default an obfuscated input is self-contained: it renders its own
  # Edit/Cancel toggle. Pass +edit_group: true+ to instead defer to an ambient
  # Alpine `editing` flag supplied by an enclosing `x-data` scope, so several
  # inputs can share a single Edit button (e.g. routing + account under one
  # bank-details Edit). The enclosing scope owns the Edit/Cancel buttons and an
  # `editing` boolean; its Cancel must clear `[data-obfuscated-input]`. Pass
  # +editing_initially+ to mirror that scope's server-rendered initial state so
  # the inputs' disabled state stays in sync.
  def initialize(form:, method:, label:, help_text: nil, optional: false, css_class: nil, input_attrs: {},
    obfuscate: false, confirmation_method: nil, confirmation_label: nil, confirmation_help_text: nil,
    edit_group: false, editing_initially: nil)
    super(form:, method:, css_class:, input_attrs:)
    @label = label
    @help_text = help_text
    @optional = optional
    @obfuscate = obfuscate
    @confirmation_method = confirmation_method
    @confirmation_label = confirmation_label
    @confirmation_help_text = confirmation_help_text
    @edit_group = edit_group
    @editing_initially_override = editing_initially
  end

  private

  def confirmation?
    @confirmation_method.present?
  end

  # The default, simplest path: a single plain input with no obfuscation.
  def plain?
    !@obfuscate && !confirmation?
  end

  # The inputs to render, in order. Each describes one text field.
  def fields
    list = [{method: @method, label: @label, help_text: @help_text}]
    if confirmation?
      list << {method: @confirmation_method, label: @confirmation_label, help_text: @confirmation_help_text}
    end
    list
  end

  # A field's label, with the "(optional)" marker appended when applicable.
  def field_label(field)
    return field[:label] unless @optional
    safe_join([field[:label], " ", tag.span("(#{I18n.t("cfaui.optional")})", class: "font-normal")])
  end

  # The saved value with whitespace removed, used only to derive the obfuscated
  # summary. Kept alphanumeric-agnostic so it works for numeric banking numbers
  # and alphanumeric IDs (e.g. a driver's license ending in a letter) alike.
  def saved_significant_chars
    current_value.to_s.gsub(/\s/, "")
  end

  # A value was previously saved, so the obfuscated view + Edit toggle apply.
  def saved_value?
    saved_significant_chars.present?
  end

  def last_four
    saved_significant_chars.last(4)
  end

  def masked_value
    "#{MASK_PREFIX}#{last_four}"
  end

  # Whether the most recent submit left validation errors on any field.
  def errors?
    fields.any? { |field| @form.object.errors[field[:method]].any? }
  end

  # Start in edit mode when there's nothing saved yet (first entry) or when the
  # last submit failed validation (so the submitted values stay visible for
  # correction). Otherwise (a clean revisit) start in the obfuscated view. A
  # grouped input defers to the state its enclosing scope computed.
  def editing_initially?
    return @editing_initially_override unless @editing_initially_override.nil?
    !saved_value? || errors?
  end

  # Attributes for a field's text input. When obfuscating, on a clean revisit the
  # input is rendered empty (so the raw value never enters the DOM) and disabled
  # (so it isn't submitted, leaving the saved value untouched); the disabled
  # state is bound to Alpine's `editing` so Edit re-enables it.
  def text_field_options(field)
    method = field[:method]
    errored = @form.object.errors[method].any?

    options = {class: "w-full max-w-sm"}
    options["aria-required"] = "true" unless @optional
    options["aria-invalid"] = "true" if errored

    described_by = []
    described_by << @form.field_id(method, :help) if field[:help_text].present?
    described_by << @form.field_id(method, :error) if errored
    options["aria-describedby"] = described_by.join(" ") if described_by.any?

    if @obfuscate
      options["data-obfuscated-input"] = ""
      # Never pre-fill the saved value; the only exception is keeping a field's
      # own just-submitted value visible so the user can correct its error.
      options[:value] = "" unless errored
      if saved_value? || @edit_group
        options["x-bind:disabled"] = "!editing"
        options[:disabled] = true unless editing_initially?
      end
    end

    field_attrs(**options)
  end
end
