# frozen_string_literal: true

require "application_system_test_case"

# Several custom widgets manage their visible state in JS while the submitted
# value lives in a hidden native control. A native form.reset() resets the
# native control but not the widget, desyncing them. These specs drive the
# realistic form_example preview (a real <form> with a "Start over" reset button)
# and assert each widget returns to its initial state on reset.
class FormResetTest < JavaScriptSystemTestCase
  def visit_form
    visit "/rails/view_components/form_example/default"
  end

  def reset_form
    find("button[type='reset']").click
  end

  test "cfaSelect month picker resets to its placeholder" do
    visit_form
    month = find("button[role='combobox']")
    hidden = find("input[type='hidden'][name*='my_date(2i)']", visible: :all)

    month.click
    find("li[role='option']", text: "March").click
    assert_equal "March", month.text.strip
    assert_equal "3", hidden.value

    reset_form

    assert_equal "- Select -", month.text.strip
    assert_equal "", hidden.value
  end

  test "combobox resets its visible input to the initial selection" do
    visit_form
    combobox = find("input[role='combobox']")

    combobox.click
    find("li[role='option']", text: "Banana").click
    assert_equal "Banana", combobox.value

    reset_form

    # Initial selection was empty, so the input clears rather than staying "Banana".
    assert_equal "", combobox.value
  end

  test "resetting hides a conditional revealed by a radio" do
    visit_form
    claimed_yes = "input[type=radio][id*='pineapple_pizza_preference_yes_claimed']"

    assert_no_text "Who claimed you?"

    find(claimed_yes).click
    assert_text "Who claimed you?"

    reset_form

    assert_no_selector "#{claimed_yes}:checked"
    assert_no_text "Who claimed you?"
  end
end
