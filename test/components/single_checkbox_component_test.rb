# frozen_string_literal: true

require "test_helper"

class SingleCheckboxComponentTest < ViewComponent::TestCase
  def test_renders_checkbox_with_label
    render_inline(SingleCheckboxComponent.new(form: build_form, method: :checkbox_field, label: "I agree"))
    assert_selector "input[type='checkbox']"
    assert_selector "label", text: "I agree"
  end

  def test_disabled_adds_opacity_and_disables_input
    render_inline(SingleCheckboxComponent.new(form: build_form, method: :checkbox_field, label: "I agree", disabled: true))
    assert_selector ".opacity-50"
    assert_selector "input[disabled]"
  end

  def test_no_duplicate_hidden_field
    render_inline(SingleCheckboxComponent.new(form: build_form, method: :checkbox_field, label: "I agree"))
    assert_selector "input[type='hidden'][name='component_test_model[checkbox_field]']", visible: :all, count: 1
  end

  def test_error_state_applies_red_border
    model = ComponentTestModel.new
    model.errors.add(:checkbox_field, "must be accepted")
    render_inline(SingleCheckboxComponent.new(form: build_form(model), method: :checkbox_field, label: "I agree"))
    assert_selector "input.checkbox-error"
  end
end
