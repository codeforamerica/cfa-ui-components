# frozen_string_literal: true

require "test_helper"

class ExclusiveCheckboxGroupComponentTest < ViewComponent::TestCase
  def test_renders_options_content_in_options_section
    render_inline(ExclusiveCheckboxGroupComponent.new) do
      '<input type="checkbox" name="opt" data-test="opt" />'.html_safe
    end

    assert_selector "[data-exclusive-checkbox-group='options'] input[data-test='opt']"
  end

  def test_renders_exclusive_option_in_exclusive_section
    component = ExclusiveCheckboxGroupComponent.new
    component.with_exclusive_option { '<input type="checkbox" name="ex" data-test="ex" />'.html_safe }

    render_inline(component) do
      '<input type="checkbox" name="opt" data-test="opt" />'.html_safe
    end

    assert_selector "[data-exclusive-checkbox-group='exclusive'] input[data-test='ex']"
    assert_selector "[data-exclusive-checkbox-group='options'] input[data-test='opt']"
  end

  def test_omits_exclusive_section_when_no_exclusive_option_provided
    render_inline(ExclusiveCheckboxGroupComponent.new) do
      '<input type="checkbox" name="opt" />'.html_safe
    end

    assert_no_selector "[data-exclusive-checkbox-group='exclusive']"
  end

  def test_wires_alpine_change_handlers
    component = ExclusiveCheckboxGroupComponent.new
    component.with_exclusive_option { "exclusive".html_safe }

    html = render_inline(component) { "options".html_safe }.to_html

    assert_includes html, %(@change="onOptionChange($event)")
    assert_includes html, %(@change="onExclusiveChange($event)")
    assert_includes html, "x-data="
  end
end
