# frozen_string_literal: true

require "application_system_test_case"

class ConditionalWithRadioButtonsTest < JavaScriptSystemTestCase
  test "selecting the matching radio value reveals the conditional section" do
    visit "/rails/view_components/conditional_component/radio_buttons"

    assert_no_text "But why!?"

    choose "Yes"

    assert_text "But why!?"
  end

  test "selecting a non-matching radio value hides the conditional section" do
    visit "/rails/view_components/conditional_component/radio_buttons"

    choose "Yes"
    assert_text "But why!?"

    choose "No"
    assert_no_text "But why!?"
  end

  test "prefilled radio value shows conditional on page load" do
    visit "/rails/view_components/conditional_component/prefilled_radio_buttons"

    assert_text "Header"
  end
end
