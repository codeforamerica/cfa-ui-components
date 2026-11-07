# frozen_string_literal: true

require "application_system_test_case"

class PreviewAccessibilityTest < JavaScriptSystemTestCase
  AXE_SOURCE = Rails.root.join("node_modules/axe-core/axe.min.js").read
  WCAG_TAGS = %w[wcag2a wcag2aa wcag21a wcag21aa wcag22aa].freeze
  # Previews render one component in isolation, so page-level structure rules don't apply.
  PAGE_LEVEL_RULES = %w[region landmark-one-main page-has-heading-one].freeze

  ViewComponent::Preview.all.each do |preview|
    preview.examples.each do |example|
      path = "/rails/view_components/#{preview.preview_name}/#{example}"

      test "#{preview.preview_name}/#{example} has no axe violations" do
        visit path
        violations = axe_violations

        assert violations.empty?, violations.map { |v| "#{v["id"]} (#{v["nodes"].size} nodes): #{v["help"]}\n  #{v["nodes"].first["html"]}" }.join("\n")
      end
    end
  end

  private

  def axe_violations
    page.execute_script(AXE_SOURCE)
    page.evaluate_async_script(<<~JS, WCAG_TAGS + ["best-practice"], PAGE_LEVEL_RULES)
      const [tags, disabledRules, done] = arguments;
      const rules = Object.fromEntries(disabledRules.map((id) => [id, {enabled: false}]));
      axe.run(document, {runOnly: tags, rules}).then((results) => done(results.violations));
    JS
  end
end
