# frozen_string_literal: true

require "application_system_test_case"

class CupriteDriverOptionsTest < JavaScriptSystemTestCase
  test "the browser starts with the configured timeouts" do
    visit "/rails/view_components"

    options = page.driver.browser.options
    assert_equal 30, options.process_timeout
    assert_equal 30, options.timeout
  end
end
