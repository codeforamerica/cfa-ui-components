# frozen_string_literal: true

require "test_helper"

class ExclusiveCheckboxGroupComponentTest < ViewComponent::TestCase
  def test_renders_options_content_in_options_section
    render_inline(ExclusiveCheckboxGroupComponent.new(legend: "Group")) do
      '<input type="checkbox" name="opt" data-test="opt" />'.html_safe
    end

    assert_selector "[data-exclusive-checkbox-group='options'] input[data-test='opt']"
  end

  def test_renders_exclusive_option_in_exclusive_section
    component = ExclusiveCheckboxGroupComponent.new(legend: "Group")
    component.with_exclusive_option { '<input type="checkbox" name="ex" data-test="ex" />'.html_safe }

    render_inline(component) do
      '<input type="checkbox" name="opt" data-test="opt" />'.html_safe
    end

    assert_selector "[data-exclusive-checkbox-group='exclusive'] input[data-test='ex']"
    assert_selector "[data-exclusive-checkbox-group='options'] input[data-test='opt']"
  end

  def test_omits_exclusive_section_when_no_exclusive_option_provided
    render_inline(ExclusiveCheckboxGroupComponent.new(legend: "Group")) do
      '<input type="checkbox" name="opt" />'.html_safe
    end

    assert_no_selector "[data-exclusive-checkbox-group='exclusive']"
  end

  def test_wires_alpine_change_handlers
    component = ExclusiveCheckboxGroupComponent.new(legend: "Group")
    component.with_exclusive_option { "exclusive".html_safe }

    html = render_inline(component) { "options".html_safe }.to_html

    assert_includes html, %(@change="onOptionChange($event)")
    assert_includes html, %(@change="onExclusiveChange($event)")
    assert_includes html, %(@click="handleItemClick($event)")
    assert_includes html, "x-data="
  end

  def test_renders_fieldset
    render_inline(ExclusiveCheckboxGroupComponent.new(legend: "Group")) do
      '<input type="checkbox" name="opt" />'.html_safe
    end

    assert_selector "fieldset.fieldset-group"
  end

  def test_raises_when_neither_legend_nor_aria_labelledby_provided
    assert_raises(ArgumentError) do
      ExclusiveCheckboxGroupComponent.new
    end
  end

  def test_renders_sr_only_legend_when_provided
    render_inline(ExclusiveCheckboxGroupComponent.new(legend: "Select all that apply")) do
      '<input type="checkbox" name="opt" />'.html_safe
    end

    assert_selector "fieldset > legend.sr-only", text: "Select all that apply"
  end

  def test_aria_labelledby_sets_fieldset_attribute_without_legend
    render_inline(ExclusiveCheckboxGroupComponent.new(aria_labelledby: "external-heading")) do
      '<input type="checkbox" name="opt" />'.html_safe
    end

    assert_selector "fieldset[aria-labelledby='external-heading']"
    assert_no_selector "legend"
  end
end
