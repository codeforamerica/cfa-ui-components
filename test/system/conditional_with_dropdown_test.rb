# frozen_string_literal: true

require "application_system_test_case"

class ConditionalWithDropdownTest < ApplicationSystemTestCase
  test "selecting the matching dropdown value reveals the conditional section" do
    visit "/rails/view_components/conditional_component/dropdown"

    assert_no_text "But why!?"

    select "Banana", from: "Favorite fruits"

    assert_text "But why!?"
  end

  test "changing dropdown away from matching value hides the conditional" do
    visit "/rails/view_components/conditional_component/dropdown"

    select "Banana", from: "Favorite fruits"
    assert_text "But why!?"

    select "Orange", from: "Favorite fruits"
    assert_no_text "But why!?"
  end

  test "prefilled dropdown value shows conditional on page load" do
    visit "/rails/view_components/conditional_component/prefilled_dropdown"

    assert_text "Header"
  end
end
