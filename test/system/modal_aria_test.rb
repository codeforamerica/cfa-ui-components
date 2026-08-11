# frozen_string_literal: true

require "application_system_test_case"

class ModalAriaTest < JavaScriptSystemTestCase
  test "open modal aria-labelledby references the header h1 id" do
    visit "/rails/view_components/modal_component/default"

    click_button "Open Modal"

    dialog = find("[role='dialog']", visible: true)
    h1 = dialog.find("h1")

    assert h1["id"].present?, "h1 should have an id set by Alpine $id()"
    assert_equal h1["id"], dialog["aria-labelledby"],
      "dialog aria-labelledby should reference the h1 id"
  end
end
