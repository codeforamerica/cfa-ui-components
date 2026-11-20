# frozen_string_literal: true

require "application_system_test_case"

class AlertDismissalSystemTest < JavaScriptSystemTestCase
  PREVIEW_PATH = "/rails/view_components/alert_component/dismissible_across_pages"

  test "a closed alert stays closed on the next page load" do
    visit PREVIEW_PATH
    find("button[aria-label='Dismiss alert']").click
    assert_no_text "This is not legal advice"

    visit PREVIEW_PATH
    assert_no_selector ".cfa-alert", visible: :all
  end

  test "an alert without a copy scope comes back on the next page load" do
    visit "/rails/view_components/alert_component/dismissible"
    find("button[aria-label='Dismiss alert']").click
    assert_no_text "This is not legal advice"

    visit "/rails/view_components/alert_component/dismissible"
    assert_text "This is not legal advice"
  end

  test "hides the alert when the page is restored from the bfcache after a dismissal elsewhere" do
    visit PREVIEW_PATH
    assert_text "This is not legal advice"

    # Headless Chrome doesn't use the bfcache, so simulate a restore after the cookie was set on a later page.
    cookie_name = AlertComponent.new(dismissible: true, copy_scope: "cfaui.alert").dismissal_cookie_name
    page.execute_script(<<~JS)
      document.cookie = "#{cookie_name}=1; path=/";
      window.dispatchEvent(new PageTransitionEvent("pageshow", { persisted: true }));
    JS

    assert_no_text "This is not legal advice"
  end

  test "hides the alert when Turbo restores the page from its snapshot cache after a dismissal elsewhere" do
    visit PREVIEW_PATH
    assert_text "This is not legal advice"

    page.execute_script(%(Turbo.visit("/rails/view_components/alert_component/default")))
    assert_current_path "/rails/view_components/alert_component/default"

    cookie_name = AlertComponent.new(dismissible: true, copy_scope: "cfaui.alert").dismissal_cookie_name
    page.execute_script(%(document.cookie = "#{cookie_name}=1; path=/"; history.back();))
    assert_current_path PREVIEW_PATH

    assert_no_text "This is not legal advice"
  end
end
