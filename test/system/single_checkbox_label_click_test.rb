# frozen_string_literal: true

require "application_system_test_case"

class SingleCheckboxLabelClickTest < ApplicationSystemTestCase
  test "clicking the label toggles the checkbox" do
    visit "/rails/view_components/single_checkbox_component/default"

    assert_no_checked_field "Default"

    find("label", text: "Default").click

    assert_checked_field "Default"
  end
end
