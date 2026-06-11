# frozen_string_literal: true

require "test_helper"

class ConditionalComponentTest < ViewComponent::TestCase
  def test_renders_content
    render_inline(ConditionalComponent.new(method: :radio_field, value: "yes")) { "Conditional content" }
    assert_text "Conditional content"
  end

  def test_x_effect_references_method_and_value
    render_inline(ConditionalComponent.new(method: :radio_field, value: "yes"))
    assert_selector "div[x-effect*='radio_field']"
    assert_selector "div[x-effect*=\"'yes'\"]"
  end

  def test_live_region_starts_empty_and_announces_via_announcement_state
    render_inline(ConditionalComponent.new(method: :radio_field, value: "yes"))
    # The live region renders empty so it is not reachable during normal
    # navigation; Alpine fills it only when visibility changes.
    assert_selector "p[aria-live='polite'][role='status'][x-text='announcement']"
    assert_no_text "is now"
  end

  def test_custom_content_description_used_in_announcement
    render_inline(ConditionalComponent.new(method: :radio_field, value: "yes", content_description: "Extra fields"))
    assert_selector "div[x-data*='Extra fields is now ']"
  end
end
