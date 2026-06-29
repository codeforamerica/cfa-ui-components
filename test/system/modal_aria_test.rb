# frozen_string_literal: true

require "application_system_test_case"

class ModalAriaTest < JavaScriptSystemTestCase
  test "open dialog aria-labelledby references the header h1 id" do
    visit "/rails/view_components/modal_component/default"

    click_button "Open Modal"

    dialog = find("dialog[open]")
    h1 = find("h1")

    assert h1["id"].present?, "h1 should have an id for aria-labelledby to reference"
    assert_equal h1["id"], dialog["aria-labelledby"],
      "dialog aria-labelledby should reference the h1 id"
  end
end
