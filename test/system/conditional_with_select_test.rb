# frozen_string_literal: true

require "application_system_test_case"

class ConditionalWithSelectTest < JavaScriptSystemTestCase
  test "selecting the matching select value reveals the conditional section" do
    visit "/rails/view_components/conditional_component/select"

    assert_no_text "But why!?"

    select_from_combobox "Banana"

    assert_text "But why!?"
  end

  test "changing select away from matching value hides the conditional" do
    visit "/rails/view_components/conditional_component/select"

    select_from_combobox "Banana"
    assert_text "But why!?"

    select_from_combobox "Orange"
    assert_no_text "But why!?"
  end

  test "prefilled select value shows conditional on page load" do
    visit "/rails/view_components/conditional_component/prefilled_select"

    assert_text "Header"
  end

  private

  # SelectComponent renders a custom Alpine combobox (a button + a role="listbox"),
  # not a native <select>, so Capybara's `select ... from:` helper can't drive it.
  # Open the listbox and click the matching option instead.
  def select_from_combobox(option_label)
    find("[role='combobox']").click
    find("[role='option']", text: option_label).click
  end
end
