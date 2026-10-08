# frozen_string_literal: true

require "test_helper"

class FieldsetLegendComponentTest < ViewComponent::TestCase
  def test_legend_renders_sr_only
    render_inline(FieldsetLegendComponent.new(legend: "Pick one"))

    assert_selector "legend.sr-only", text: "Pick one"
  end

  def test_heading_renders_visible_heading_inside_legend
    render_inline(FieldsetLegendComponent.new(heading: "Date of birth"))

    assert_selector "legend.fieldset-heading > h2", text: "Date of birth"
    assert_no_selector "legend.sr-only"
  end

  def test_heading_level_sets_heading_tag
    render_inline(FieldsetLegendComponent.new(heading: "Is your dependent married?", heading_level: 3))

    assert_selector "legend > h3", text: "Is your dependent married?"
  end

  def test_renders_nothing_without_legend_or_heading
    render_inline(FieldsetLegendComponent.new)

    assert_no_selector "legend"
  end

  def test_raises_when_legend_and_heading_both_given
    assert_raises(ArgumentError) do
      FieldsetLegendComponent.new(legend: "Pick one", heading: "Pick one")
    end
  end

  def test_raises_on_invalid_heading_level
    assert_raises(ArgumentError) do
      FieldsetLegendComponent.new(heading: "Pick one", heading_level: 7)
    end
  end
end
