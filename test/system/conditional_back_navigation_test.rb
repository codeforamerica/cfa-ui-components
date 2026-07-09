# frozen_string_literal: true

require "application_system_test_case"
class ConditionalBackNavigationTest < JavaScriptSystemTestCase
  test "pageshow resyncs the store from a restored radio selection" do
    visit "/rails/view_components/conditional_component/radio_buttons"

    assert_no_text "But why!?"

    # Simulate the browser restoring "Yes" without notifying Alpine.
    page.execute_script(<<~JS)
      const yes = document.querySelector('input[type=radio][x-model^="$store."][value="yes"]');
      yes.checked = true;
    JS
    assert_no_text "But why!?"

    page.execute_script("window.dispatchEvent(new Event('pageshow'));")

    assert_text "But why!?"
  end

  test "pageshow resyncs the store from a restored checkbox selection" do
    visit "/rails/view_components/conditional_component/checkboxes"

    assert_no_text "But why!?"

    page.execute_script(<<~JS)
      const banana = document.querySelector('input[type=checkbox][x-model^="$store."][value="banana"]');
      banana.checked = true;
    JS
    assert_no_text "But why!?"

    page.execute_script("window.dispatchEvent(new Event('pageshow'));")

    assert_text "But why!?"
  end
end
