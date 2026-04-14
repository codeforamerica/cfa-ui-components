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
end
