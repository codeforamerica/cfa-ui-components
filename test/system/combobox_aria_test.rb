# frozen_string_literal: true

require "application_system_test_case"

class ComboboxAriaTest < JavaScriptSystemTestCase
  test "search input aria-labelledby references the visible label" do
    visit "/rails/view_components/combobox_component/default"

    label = find("label[x-combobox\\:label]")
    input = find("input[role='combobox']")

    assert label["id"].present?, "label should have an id set by Alpine $id()"
    assert_equal label["id"], input["aria-labelledby"],
      "combobox input aria-labelledby should reference the label id"
  end

  test "search input has role combobox" do
    visit "/rails/view_components/combobox_component/default"

    assert_selector "input[role='combobox']"
  end

  test "reopening the dropdown after a full selection shows all options" do
    visit "/rails/view_components/combobox_component/default"

    input = find("input[role='combobox']")
    input.click
    find("li[role='option']", text: "Apricot").click
    assert_equal "Apricot", input.value

    input.click
    assert_selector "li[role='option']:not([style*='display: none'])", text: "Banana"
  end

  test "reopening the dropdown with a prefilled disabled option shows valid options" do
    visit "/rails/view_components/combobox_component/prefilled_disabled_option"

    input = find("input[role='combobox']")
    input.click

    assert_selector "li[role='option']:not([style*='display: none'])", text: "Apple"
    find("li[role='option']", text: "Apple").click
    assert_equal "Apple", input.value
  end

  test "search input aria-describedby references the error message" do
    visit "/rails/view_components/combobox_component/with_error"

    input = find("input[role='combobox']")
    error = find("p.form_errors")

    assert error["id"].present?, "error message should have an id"
    assert_includes input["aria-describedby"].to_s.split, error["id"],
      "combobox input aria-describedby should reference the error message id"
  end
end
