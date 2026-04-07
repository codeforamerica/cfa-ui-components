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

  def test_custom_content_description_in_aria_live
    render_inline(ConditionalComponent.new(method: :radio_field, value: "yes", content_description: "Extra fields"))
    assert_selector "p[aria-live='polite'][x-text*='Extra fields']"
  end
end
