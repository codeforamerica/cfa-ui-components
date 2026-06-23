# frozen_string_literal: true

require "test_helper"

# Tests that every component with a label correctly associates it with its
# input via matching for/id attributes (or aria-labelledby for non-form components).
# Catches the class of bug fixed in 3e88f561.
class LabelInputAssociationTest < ViewComponent::TestCase
  def test_text_field_label_for_matches_input_id
    render_inline(InputComponent.new(
      form: build_form, method: :text_field, label: "Full name"
    ))

    label_for = page.find("label")["for"]
    assert label_for.present?, "label should have a 'for' attribute"
    assert_selector "input##{label_for}"
  end

  def test_select_label_for_matches_combobox_id
    render_inline(SelectComponent.new(
      form: build_form,
      method: :select_field,
      label: "Pick one",
      collection: simple_collection,
      item_value_method: :value,
      item_label_method: :label
    ))

    label_for = page.find("label")["for"]

    assert label_for.present?, "label should have a 'for' attribute"
    assert_selector "button##{label_for}[role='combobox']"
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
      item_label_method: :label,
      legend: "Pick some"
    ))

    items = page.all(".form_item")
    assert items.any?, "expected at least one .form_item"
    items.each do |item|
      label = item.find("label")
      checkbox = item.find("input[type='checkbox']")
      assert_equal checkbox["id"], label["for"],
        "Label for='#{label["for"]}' should match checkbox id='#{checkbox["id"]}'"
    end
  end

  def test_radio_buttons_each_label_matches_its_radio
    render_inline(RadioButtonsComponent.new(
      form: build_form,
      method: :radio_field,
      collection: simple_collection,
      item_value_method: :value,
      item_label_method: :label,
      legend: "Pick one"
    ))

    items = page.all(".form_item")
    assert items.any?, "expected at least one .form_item"
    items.each do |item|
      label = item.find("label")
      radio = item.find("input[type='radio']")
      assert_equal radio["id"], label["for"],
        "Label for='#{label["for"]}' should match radio id='#{radio["id"]}'"
    end
  end

  def test_prefilled_text_field_heading_aria_labelledby_matches_label_id
    render_inline(PrefilledTextFieldComponent.new(
      text: "John Doe", label: "Full name", heading: :h2
    ))

    label = page.find("h2.label")
    label_id = label["id"]
    value = page.find("span[aria-labelledby]")

    assert label_id.present?, "label heading should have an id"
    assert_equal label_id, value["aria-labelledby"],
      "Value span's aria-labelledby should reference the label heading's id"
  end

  def test_prefilled_text_field_uses_description_list_association
    render_inline(PrefilledTextFieldComponent.new(
      text: "John Doe", label: "Full name"
    ))

    assert_selector "dl dt.label", text: "Full name"
    assert_selector "dl dd", text: "John Doe"
  end
end
