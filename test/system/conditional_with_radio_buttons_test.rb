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

  test "no visibility announcement is present on initial page load" do
    visit "/rails/view_components/conditional_component/radio_buttons"

    assert_no_text "is now visible"
    assert_no_text "is now hidden"
  end

  test "prefilled value does not announce on page load" do
    visit "/rails/view_components/conditional_component/prefilled_radio_buttons"

    assert_text "Header"
    assert_no_text "is now visible"
    assert_no_text "is now hidden"
  end

  test "changing the selection announces the new visibility" do
    visit "/rails/view_components/conditional_component/radio_buttons"

    choose "Yes"
    assert_selector "[role='status']", text: "is now visible"

    choose "No"
    assert_selector "[role='status']", text: "is now hidden"
  end
end
