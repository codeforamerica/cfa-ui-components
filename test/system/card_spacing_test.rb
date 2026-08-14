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
end
