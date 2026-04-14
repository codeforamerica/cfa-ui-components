# frozen_string_literal: true

require "test_helper"

# Tests that every component with a label correctly associates it with its
# input via matching for/id attributes (or aria-labelledby for non-form components).
# Catches the class of bug fixed in 3e88f561.
class LabelInputAssociationTest < ViewComponent::TestCase
  def test_text_field_label_for_matches_input_id
    render_inline(TextFieldComponent.new(
      form: build_form, method: :text_field, label: "Full name"
    ))

    label_for = page.find("label")["for"]
    assert label_for.present?, "label should have a 'for' attribute"
    assert_selector "input##{label_for}"
  end

  def test_dropdown_label_for_matches_select_id
    render_inline(DropdownComponent.new(
      form: build_form,
      method: :dropdown_field,
      label: "Pick one",
      collection: simple_collection,
      item_value_method: :value,
      item_label_method: :label
    ))

    label_for = page.find("label")["for"]
    assert label_for.present?, "label should have a 'for' attribute"
    assert_selector "select##{label_for}"
  end

  def test_combobox_label_for_matches_select_id
    render_inline(ComboboxComponent.new(
      form: build_form,
      method: :combobox_field,
      label: "Choose fruit",
      collection: simple_collection,
      item_value_method: :value,
      item_label_method: :label
    ))

    label_for = page.find("label")["for"]
    assert label_for.present?, "label should have a 'for' attribute"
    assert_selector "select##{label_for}"
  end

  def test_single_checkbox_label_for_matches_checkbox_id
    render_inline(SingleCheckboxComponent.new(
      form: build_form, method: :checkbox_field, label: "I agree"
    ))

    label_for = page.find("label")["for"]
    assert label_for.present?, "label should have a 'for' attribute"
    assert_selector "input[type='checkbox']##{label_for}"
  end

  def test_checkboxes_each_label_matches_its_checkbox
    render_inline(CheckboxesComponent.new(
      form: build_form,
      method: :checkboxes_field,
      collection: simple_collection,
      item_value_method: :value,
      item_label_method: :label
    ))

    page.all(".checkbox_item").each do |item|
      label = item.find("label")
      checkbox = item.find("input[type='checkbox']")
      assert_equal checkbox["id"], label["for"],
        "Label for='#{label['for']}' should match checkbox id='#{checkbox['id']}'"
    end
  end

  def test_radio_buttons_each_label_matches_its_radio
    render_inline(RadioButtonsComponent.new(
      form: build_form,
      method: :radio_field,
      collection: simple_collection,
      item_value_method: :value,
      item_label_method: :label
    ))

    page.all(".radio_button_item").each do |item|
      label = item.find("label")
      radio = item.find("input[type='radio']")
      assert_equal radio["id"], label["for"],
        "Label for='#{label['for']}' should match radio id='#{radio['id']}'"
    end
  end

  def test_prefilled_text_field_aria_labelledby_matches_label_id
    render_inline(PrefilledTextFieldComponent.new(
      text: "John Doe", label: "Full name"
    ))

    spans = page.all("span")
    label_span = spans.first
    value_span = spans.last
    label_id = label_span["id"]

    assert label_id.present?, "label span should have an id"
    assert_equal label_id, value_span["aria-labelledby"],
      "Value span's aria-labelledby should reference the label span's id"
  end
end
