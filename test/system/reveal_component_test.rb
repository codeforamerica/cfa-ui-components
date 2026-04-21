# frozen_string_literal: true

require "application_system_test_case"

class RevealComponentTest < JavaScriptSystemTestCase
  test "content is hidden on page load" do
    visit "/rails/view_components/reveal_component/default"

    assert_no_text "Sample Details"
  end

  test "clicking summary reveals content" do
    visit "/rails/view_components/reveal_component/default"

    find("summary").click

    assert_text "Sample Details"
  end

  test "clicking summary again hides content" do
    visit "/rails/view_components/reveal_component/default"

    find("summary").click
    assert_text "Sample Details"

    find("summary").click
    assert_no_text "Sample Details"
  end
end
