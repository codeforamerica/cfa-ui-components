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
end
