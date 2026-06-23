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

  test "search input aria-describedby references the error message" do
    visit "/rails/view_components/combobox_component/with_error"

    input = find("input[role='combobox']")
    error = find("p.form_errors")

    assert error["id"].present?, "error message should have an id"
    assert_includes input["aria-describedby"].to_s.split, error["id"],
      "combobox input aria-describedby should reference the error message id"
  end
end
