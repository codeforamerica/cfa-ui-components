# frozen_string_literal: true

require "application_system_test_case"

# Cascade-contract test: asserts the *computed* spacing that encodes design
# intent, rather than pixel-diffing. Catches cascade / layer-order regressions
# deterministically (e.g. a fieldset margin reset overriding `.cfa-card > * + *`)
# without being brittle to unrelated changes.
#
# NOTE: this is only trustworthy because the preview layout loads the single
# compiled `application` bundle. The old `stylesheet_link_tag :app` glob
# double-loaded CSS and masked exactly this class of bug.
class CardSpacingTest < JavaScriptSystemTestCase
  # --spacing-cfa-med
  CARD_CHILD_GAP = "16px"

  test "a fieldset directly inside a card keeps its top margin below the heading" do
    visit "/rails/view_components/card_component/card_with_radio_fieldset"

    margin_top = evaluate_script(
      "getComputedStyle(document.querySelector('.cfa-card > fieldset.fieldset-group')).marginTop"
    )
    assert_equal CARD_CHILD_GAP, margin_top,
      "The fieldset should keep `.cfa-card > * + *` spacing below the heading; " \
      "a margin reset on `.fieldset-group` likely collapsed it."
  end

  test "a memorable date directly inside a card keeps its top margin below the previous field" do
    visit "/rails/view_components/card_component/card_with_memorable_date"

    margin_top = evaluate_script(
      "getComputedStyle(document.querySelector('.cfa-card > fieldset.memorable-date')).marginTop"
    )
    assert_equal CARD_CHILD_GAP, margin_top,
      "The memorable date should keep `.cfa-card > * + *` spacing below the previous field; " \
      "a margin reset on `.memorable-date` likely collapsed it."
  end

  test "a fieldset heading sits 4px above date helper text and 16px above radio options" do
    visit "/rails/view_components/card_component/card_with_fieldset_headings"

    gaps = evaluate_script(<<~JS)
      (() => {
        const gap = (a, b) => Math.round(document.querySelector(b).getBoundingClientRect().top - document.querySelector(a).getBoundingClientRect().bottom);
        return {
          aboveDate: gap(".cfa-card > div", ".cfa-card > fieldset.memorable-date"),
          headingToHelper: gap("fieldset.memorable-date legend h2", "fieldset.memorable-date .help_text"),
          helperToFields: gap("fieldset.memorable-date .help_text", "fieldset.memorable-date label"),
          headingToOptions: gap("fieldset.fieldset-group legend h2", "fieldset.fieldset-group .form_item")
        };
      })()
    JS
    assert_equal({"aboveDate" => 16, "headingToHelper" => 4, "helperToFields" => 8, "headingToOptions" => 16}, gaps)
  end
end
