# frozen_string_literal: true

require "application_system_test_case"

class SensitiveFieldBackNavigationTest < JavaScriptSystemTestCase
  test "marks a page containing a sensitive field as uncacheable for Turbo" do
    visit "/rails/view_components/tin_component/default"

    assert_selector "meta[name='turbo-cache-control'][content='no-cache']", visible: :all
  end

  test "does not mark a page without a sensitive field as uncacheable" do
    visit "/rails/view_components/conditional_component/radio_buttons"

    assert_no_selector "meta[name='turbo-cache-control']", visible: :all
  end

  test "reloads a sensitive page when it is restored from the bfcache" do
    visit "/rails/view_components/tin_component/default"

    # A node injected at runtime survives a Turbo restoration but not a full
    # reload, so its disappearance proves the reload fired.
    page.execute_script(<<~JS)
      document.body.insertAdjacentHTML("beforeend", "<div id='reload-sentinel'></div>");
    JS
    assert_selector "#reload-sentinel"

    page.execute_script(<<~JS)
      window.dispatchEvent(new PageTransitionEvent("pageshow", { persisted: true }));
    JS

    assert_no_selector "#reload-sentinel"
  end

  test "does not reload on a normal pageshow that is not a bfcache restore" do
    visit "/rails/view_components/tin_component/default"

    page.execute_script(<<~JS)
      document.body.insertAdjacentHTML("beforeend", "<div id='reload-sentinel'></div>");
    JS
    assert_selector "#reload-sentinel"

    page.execute_script(<<~JS)
      window.dispatchEvent(new PageTransitionEvent("pageshow", { persisted: false }));
    JS

    assert_selector "#reload-sentinel"
  end
end
