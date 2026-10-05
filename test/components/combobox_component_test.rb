# frozen_string_literal: true

require "test_helper"

class ComboboxComponentTest < ViewComponent::TestCase
  def test_renders_label_and_select
    render_inline(ComboboxComponent.new(
      form: build_form,
      method: :combobox_field,
      label: "Choose fruit",
      collection: simple_collection,
      item_value_method: :value,
      item_label_method: :label
    ))
    assert_selector "label", text: "Choose fruit"
    assert_selector "select"
    assert_selector "option", text: "Yes"
    assert_selector "option", text: "No"
  end

  def test_chevron_toggle_is_hidden_from_assistive_tech
    render_inline(ComboboxComponent.new(
      form: build_form,
      method: :combobox_field,
      label: "Choose fruit",
      collection: simple_collection,
      item_value_method: :value,
      item_label_method: :label
    ))
    # The chevron toggle is a redundant, mouse/touch-only affordance: the search
    # input already exposes open/close to assistive tech via aria-expanded, so the
    # toggle is hidden from the a11y tree and needs no accessible name.
    toggle = alpine_element("button", "x-combobox:toggle")
    assert_equal "true", toggle["aria-hidden"]
    refute toggle.key?("aria-label")
  end

  def test_toggle_and_filter_input_render_types_and_toggle_is_unfocusable_before_alpine
    render_inline(ComboboxComponent.new(
      form: build_form,
      method: :combobox_field,
      label: "Choose fruit",
      collection: simple_collection,
      item_value_method: :value,
      item_label_method: :label
    ))
    toggle = alpine_element("button", "x-combobox:toggle")
    input = alpine_element("input", "x-combobox:input")
    assert_equal "button", toggle["type"]
    assert_equal "-1", toggle["tabindex"]
    assert_equal "text", input["type"]
  end

  def test_renders_help_text
    render_inline(ComboboxComponent.new(
      form: build_form,
      method: :combobox_field,
      label: "Choose fruit",
      collection: simple_collection,
      item_value_method: :value,
      item_label_method: :label,
      help_text: "Pick one"
    ))
    assert_selector ".help_text", text: "Pick one"
  end

  def test_required_by_default_sets_aria_required_and_omits_optional_marker
    render_inline(ComboboxComponent.new(
      form: build_form,
      method: :combobox_field,
      label: "Choose fruit",
      collection: simple_collection,
      item_value_method: :value,
      item_label_method: :label
    ))
    assert_selector "label", text: "Choose fruit"
    assert_no_text "(optional)"
    assert_selector "select[aria-required='true']"
  end

  def test_optional_appends_optional_marker_and_omits_aria_required
    render_inline(ComboboxComponent.new(
      form: build_form,
      method: :combobox_field,
      label: "Choose fruit",
      collection: simple_collection,
      item_value_method: :value,
      item_label_method: :label,
      optional: true
    ))
    assert_selector "label", text: "Choose fruit (optional)"
    assert_no_selector "select[aria-required]"
  end

  def test_item_disabled_method_marks_options_disabled
    collection = [
      OpenStruct.new(value: "yes", label: "Yes", unavailable: false),
      OpenStruct.new(value: "no", label: "No", unavailable: true)
    ]
    render_inline(ComboboxComponent.new(
      form: build_form,
      method: :combobox_field,
      label: "Choose fruit",
      collection:,
      item_value_method: :value,
      item_label_method: :label,
      item_disabled_method: :unavailable
    ))
    assert_selector "option[value='no'][disabled]"
    assert_no_selector "option[value='yes'][disabled]"
  end

  def test_css_class_is_appended_to_root
    render_inline(ComboboxComponent.new(
      form: build_form,
      method: :combobox_field,
      label: "Choose fruit",
      collection: simple_collection,
      item_value_method: :value,
      item_label_method: :label,
      css_class: "mt-cfa-lg"
    ))
    assert_selector "div.max-w-sm.mt-cfa-lg"
  end

  def test_input_attrs_are_forwarded_to_the_select_and_filter_input
    result = render_inline(ComboboxComponent.new(
      form: build_form,
      method: :combobox_field,
      label: "Choose fruit",
      collection: simple_collection,
      item_value_method: :value,
      item_label_method: :label,
      input_attrs: {autocomplete: "off"}
    ))
    assert_selector "select[autocomplete='off']", visible: :all
    # The filter <input> lives inside a <template>, which Capybara won't descend
    # into, so assert on raw HTML: attribute lands on both select and input.
    assert_equal 2, result.to_html.scan('autocomplete="off"').size
  end

  def test_omits_input_attrs_when_none_given
    render_inline(ComboboxComponent.new(
      form: build_form,
      method: :combobox_field,
      label: "Choose fruit",
      collection: simple_collection,
      item_value_method: :value,
      item_label_method: :label
    ))
    assert_no_selector "select[autocomplete]", visible: :all
  end

  private

  # The input and toggle live inside <template x-if>, which Capybara's HTML4 parser
  # doesn't descend into, and Nokogiri can't match Alpine's colon attribute names
  # via CSS — so walk an HTML5 parse of the raw markup directly.
  def alpine_element(tag, alpine_attr)
    element = Nokogiri::HTML5.fragment(rendered_content).xpath(".//#{tag}").find { |el| el.key?(alpine_attr) }
    assert element, "expected a <#{tag} #{alpine_attr}> element"
    element
  end
end
