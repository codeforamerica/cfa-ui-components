# frozen_string_literal: true

require "test_helper"

class RevealComponentTest < ViewComponent::TestCase
  def test_renders_summary_text
    render_inline(RevealComponent.new(summary_text: "More details"))
    assert_selector "summary", text: /More details/
  end

  def test_renders_content
    render_inline(RevealComponent.new(summary_text: "More details")) { "Hidden content" }
    assert_text "Hidden content"
  end

  def test_renders_icon_when_provided
    render_inline(RevealComponent.new(summary_text: "More details", icon: "info_outline"))
    assert_selector "svg[role='img'][aria-label='info outline icon']"
  end

  def test_css_class_is_appended_without_dropping_base_classes
    render_inline(RevealComponent.new(summary_text: "More details", css_class: "mt-cfa-lg"))
    assert_selector "details.mt-cfa-lg.group.border-primary"
  end

  def test_collapsed_by_default
    render_inline(RevealComponent.new(summary_text: "More details"))
    assert_no_selector "details[open]"
  end

  def test_renders_open_when_open_is_true
    render_inline(RevealComponent.new(summary_text: "More details", open: true))
    assert_selector "details[open]"
  end

  def test_no_analytics_attributes_without_reveal_id
    render_inline(RevealComponent.new(summary_text: "More details"))
    assert_no_selector "details[data-analytics-event]"
  end

  def test_renders_analytics_attributes_when_reveal_id_given
    render_inline(RevealComponent.new(summary_text: "More details", reveal_id: "what_is_permanent_home"))
    assert_selector "details[data-analytics-event='reveal_clicked'][data-analytics-id='what_is_permanent_home']"
  end
end
