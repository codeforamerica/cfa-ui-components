# frozen_string_literal: true

require "test_helper"

class SingleCheckboxComponentTest < ViewComponent::TestCase
  def test_renders_checkbox_with_label
    render_inline(SingleCheckboxComponent.new(form: build_form, method: :checkbox_field, label: "I agree"))
    assert_selector "input[type='checkbox']"
    assert_selector "label", text: "I agree"
  end

  def test_disabled_styles_label_and_disables_input
    render_inline(SingleCheckboxComponent.new(form: build_form, method: :checkbox_field, label: "I agree", disabled: true))
    assert_selector "label.text-text-disabled"
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
    assert_selector "input.border-border-error"
  end

  def test_css_class_is_appended_to_root
    render_inline(SingleCheckboxComponent.new(form: build_form, method: :checkbox_field, label: "I agree", css_class: "mt-cfa-lg"))
    assert_selector "div.cfa-stack-sm.mt-cfa-lg"
  end

  def test_input_attrs_are_forwarded_to_the_field
    render_inline(SingleCheckboxComponent.new(form: build_form, method: :checkbox_field, label: "I agree", input_attrs: {data: {testid: "agree"}}))
    assert_selector "input[type='checkbox'][data-testid='agree']"
  end

  def test_input_attrs_class_augments_rather_than_clobbers_field_classes
    render_inline(SingleCheckboxComponent.new(form: build_form, method: :checkbox_field, label: "I agree", input_attrs: {class: "my-custom-class"}))
    assert_selector "input[type='checkbox'].cfa-checkbox.my-custom-class"
  end
end
