# frozen_string_literal: true

require "application_system_test_case"

class ConditionalWithCheckboxesTest < ApplicationSystemTestCase
  test "checking the matching checkbox reveals the conditional section" do
    visit "/rails/view_components/conditional_component/checkboxes"

    assert_no_text "But why!?"

    check "Banana"

    assert_text "But why!?"
  end

  test "unchecking the matching checkbox hides the conditional while others stay checked" do
    visit "/rails/view_components/conditional_component/checkboxes"

    check "Banana"
    check "Orange"
    assert_text "But why!?"

    uncheck "Banana"
    assert_no_text "But why!?"
  end

  test "prefilled checkbox value shows conditional on page load" do
    visit "/rails/view_components/conditional_component/prefilled_checkboxes"

    assert_text "Header"
  end
end
