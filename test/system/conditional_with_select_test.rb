# frozen_string_literal: true

require "application_system_test_case"

class ConditionalWithSelectTest < JavaScriptSystemTestCase
  test "selecting the matching select value reveals the conditional section" do
    visit "/rails/view_components/conditional_component/select"

    assert_no_text "But why!?"

    select "Banana", from: "Favorite fruits"

    assert_text "But why!?"
  end

  test "changing select away from matching value hides the conditional" do
    visit "/rails/view_components/conditional_component/select"

    select "Banana", from: "Favorite fruits"
    assert_text "But why!?"

    select "Orange", from: "Favorite fruits"
    assert_no_text "But why!?"
  end

  test "prefilled select value shows conditional on page load" do
    visit "/rails/view_components/conditional_component/prefilled_select"

    assert_text "Header"
  end
end
