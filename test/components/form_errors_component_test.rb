# frozen_string_literal: true

require "test_helper"

class FormErrorsComponentTest < ViewComponent::TestCase
  def test_renders_nothing_when_no_errors
    render_inline(FormErrorsComponent.new(form: build_form, method: :text_field))
    assert_no_selector ".form_errors"
  end

  def test_renders_error_message
    model = ComponentTestModel.new
    model.errors.add(:text_field, "can't be blank")
    render_inline(FormErrorsComponent.new(form: build_form(model), method: :text_field))
    assert_selector ".form_errors", text: "can't be blank"
  end

  def test_css_class_is_appended_to_root
    model = ComponentTestModel.new
    model.errors.add(:text_field, "can't be blank")
    render_inline(FormErrorsComponent.new(form: build_form(model), method: :text_field, css_class: "mt-cfa-lg"))
    assert_selector "p.form_errors.mt-cfa-lg"
  end
end
