# frozen_string_literal: true

require "application_system_test_case"

class ModalAriaTest < JavaScriptSystemTestCase
  test "open dialog aria-labelledby references the header h2 id" do
    visit "/rails/view_components/modal_component/default"

    click_button "Open Modal"

    dialog = find("dialog[open]")
    h2 = find("h2")

    assert h2["id"].present?, "h2 should have an id set by Alpine $id()"
    assert_equal h2["id"], dialog["aria-labelledby"],
      "dialog aria-labelledby should reference the h2 id"
  end
end
