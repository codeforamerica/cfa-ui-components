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

  test "visibility announcement is empty on load and populated only when visibility changes" do
    visit "/rails/view_components/conditional_component/radio_buttons"

    # Nothing to announce during normal navigation / on initial load.
    assert_equal "", find("[aria-live='polite']", visible: :all).text(:all).strip

    choose "Yes"
    assert_text "But why!?"
    assert_selector "[aria-live='polite']", text: "Followup banana question is now visible", visible: :all

    choose "No"
    assert_no_text "But why!?"
    assert_selector "[aria-live='polite']", text: "Followup banana question is now hidden", visible: :all
  end

  test "prefilled radio value does not announce on page load" do
    visit "/rails/view_components/conditional_component/prefilled_radio_buttons"

    assert_equal "", find("[aria-live='polite']", visible: :all).text(:all).strip
  end
end
