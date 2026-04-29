# frozen_string_literal: true

require "application_system_test_case"

class ExclusiveCheckboxGroupComponentTest < JavaScriptSystemTestCase
  test "checking an option clears the exclusive option" do
    visit "/rails/view_components/exclusive_checkbox_group_component/default"

    check "None of these apply"
    assert_checked_field "None of these apply"

    check "Option one"
    assert_checked_field "Option one"
    assert_no_checked_field "None of these apply"
  end

  test "checking the exclusive option clears all other options" do
    visit "/rails/view_components/exclusive_checkbox_group_component/default"

    check "Option one"
    check "Option two"
    assert_checked_field "Option one"
    assert_checked_field "Option two"

    check "None of these apply"
    assert_checked_field "None of these apply"
    assert_no_checked_field "Option one"
    assert_no_checked_field "Option two"
  end

  test "clicking anywhere on an option's container toggles its checkbox" do
    visit "/rails/view_components/exclusive_checkbox_group_component/default"

    assert_no_checked_field "Option one"

    find("p", text: "Description of option one.").click

    assert_checked_field "Option one"
  end

  test "clicking the exclusive option's container toggles its checkbox" do
    visit "/rails/view_components/exclusive_checkbox_group_component/default"

    check "Option one"
    assert_checked_field "Option one"

    find("label", text: "None of these apply").ancestor(".cfa-card").click

    assert_checked_field "None of these apply"
    assert_no_checked_field "Option one"
  end
end
