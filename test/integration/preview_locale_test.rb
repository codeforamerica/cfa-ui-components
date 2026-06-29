# frozen_string_literal: true

require "test_helper"

# Regression test for the Lookbook preview locale toggle. The `lang` display
# option arrives as a doubly-URL-encoded JSON `_display` query param, so the
# PreviewController must CGI.unescape it before JSON.parse — otherwise parsing
# raises, the rescue swallows it, and every preview silently renders in English.
class PreviewLocaleTest < ActionDispatch::IntegrationTest
  # ?_display={"lang":"es"} as Lookbook actually encodes it in the URL.
  ENCODED_SPANISH = "%257B%2522lang%2522%253A%2522es%2522%257D"

  test "preview renders Spanish when the lang display option is set" do
    get "/preview/memorable_date/default?_display=#{ENCODED_SPANISH}"

    assert_response :success
    assert_includes response.body, "Fecha de nacimiento"
    assert_includes response.body, "Mes"
    assert_includes response.body, "enero"
    assert_includes response.body, "AAAA"
    assert_not_includes response.body, "January"
    assert_not_includes response.body, "Date of birth"
    assert_not_includes response.body, "YYYY"
  end

  test "preview renders English by default" do
    get "/preview/memorable_date/default"

    assert_response :success
    assert_includes response.body, "Date of birth"
    assert_includes response.body, "Month"
    assert_includes response.body, "January"
    assert_includes response.body, "YYYY"
  end
end
