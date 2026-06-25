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

  def test_live_region_is_empty_until_visibility_changes
    render_inline(ConditionalComponent.new(method: :radio_field, value: "yes"))
    # The live region must render empty so it is not reachable during normal
    # navigation; it is populated only when condition changes (see x-init).
    assert_selector "p[aria-live='polite'][x-text='announcement']"
    assert_selector "p[aria-live='polite']", text: ""
  end

  def test_custom_content_description_used_in_announcement
    render_inline(ConditionalComponent.new(method: :radio_field, value: "yes", content_description: "Extra fields"))
    assert_selector "div[x-init*='Extra fields is now']"
  end
end
