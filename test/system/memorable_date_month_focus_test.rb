# frozen_string_literal: true

require "application_system_test_case"

# The month picker is a custom Alpine combobox whose keydown handler (and thus
# typeahead) is bound to the trigger <button>. Safari and Firefox on macOS do
# not focus a <button> on click, so opening the list must focus the button
# explicitly or keystrokes never reach the handler. cuprite runs Chromium (which
# does focus on click), so this asserts the fix directly: opening the list — even
# when nothing was focused — leaves the button focused.
class MemorableDateMonthFocusTest < JavaScriptSystemTestCase
  test "opening the month list focuses the trigger button" do
    visit "/rails/view_components/memorable_date_component/default"
    button = find("button[role='combobox']")

    # Simulate the Safari/Firefox case: open the list while nothing is focused
    # (a click there would not have focused the button).
    execute_script("document.activeElement && document.activeElement.blur()")
    execute_script(<<~JS, button["id"])
      Alpine.$data(document.getElementById(arguments[0]).closest("[x-data]")).openList();
    JS

    assert_equal button["id"], evaluate_script("document.activeElement && document.activeElement.id"),
      "opening the list should focus the button so typeahead works in Safari/Firefox"
  end
end
