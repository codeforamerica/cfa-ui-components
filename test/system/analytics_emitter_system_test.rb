# frozen_string_literal: true

require "application_system_test_case"

# Exercises analytics_emitter.ts in a real browser. The emitter is
# provider-agnostic — it only dispatches `cfa:analytics` DOM events — so these
# tests spy on those events directly rather than any Mixpanel integration.
class AnalyticsEmitterSystemTest < JavaScriptSystemTestCase
  # Records every cfa:analytics event's detail into a window array to assert on.
  def spy_on_analytics
    page.execute_script(<<~JS)
      window.cfaAnalyticsCalls = [];
      document.addEventListener("cfa:analytics", function (e) {
        window.cfaAnalyticsCalls.push(e.detail);
      });
    JS
  end

  def analytics_calls
    JSON.parse(page.evaluate_script("JSON.stringify(window.cfaAnalyticsCalls)"))
  end

  # Injects a raw <details> fixture with a marker but a controllable id, so we
  # can test the emitter's id resolution independent of the components.
  def append_details_fixture(attrs)
    page.execute_script(<<~JS)
      var d = document.createElement("details");
      #{attrs}
      d.innerHTML = "<summary>fixture</summary><p>body</p>";
      document.body.appendChild(d);
    JS
  end

  test "reveal namespaces the analytics id by controller path" do
    visit "/rails/view_components/reveal_component/with_analytics"
    spy_on_analytics

    summary = find("details[data-analytics-id='preview/sample_reveal'] summary")

    summary.click # open
    assert_equal 1, analytics_calls.size
    assert_equal({"event" => "reveal_clicked", "id" => "preview/sample_reveal"}, analytics_calls.first)

    summary.click # close — must not emit again
    assert_equal 1, analytics_calls.size
  end

  test "reveal passes through a pre-qualified analytics id unchanged" do
    visit "/rails/view_components/reveal_component/with_analytics_qualified"
    spy_on_analytics

    find("details[data-analytics-id='shared/sample_reveal'] summary").click

    assert_equal 1, analytics_calls.size
    assert_equal({"event" => "reveal_clicked", "id" => "shared/sample_reveal"}, analytics_calls.first)
  end

  test "tooltip namespaces the analytics id by controller path" do
    visit "/rails/view_components/tooltip_component/default"
    spy_on_analytics

    find("button[data-analytics-id='preview/tooltip']").click

    assert_equal 1, analytics_calls.size
    assert_equal({"event" => "tooltip_clicked", "id" => "preview/tooltip"}, analytics_calls.first)
  end

  test "falls back to the element's HTML id when no data-analytics-id is set" do
    visit "/rails/view_components/reveal_component/default"
    spy_on_analytics
    append_details_fixture(
      %(d.id = "html_id_fallback"; d.setAttribute("data-analytics-event", "reveal_clicked");)
    )

    find("details#html_id_fallback summary").click

    assert_equal 1, analytics_calls.size
    assert_equal({"event" => "reveal_clicked", "id" => "html_id_fallback"}, analytics_calls.first)
  end

  test "does not emit when neither an analytics id nor an HTML id is present" do
    visit "/rails/view_components/reveal_component/default"
    spy_on_analytics
    append_details_fixture(%(d.setAttribute("data-analytics-event", "reveal_clicked");))

    find("details summary", text: "fixture").click

    assert_empty analytics_calls
  end
end
