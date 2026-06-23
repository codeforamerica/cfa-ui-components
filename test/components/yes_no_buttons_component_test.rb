# frozen_string_literal: true

require "test_helper"

class YesNoButtonsComponentTest < ViewComponent::TestCase
  def test_renders_yes_and_no_buttons
    render_inline(YesNoButtonsComponent.new(form: build_form, method: :text_field))
    assert_selector "div.yes-no-buttons"
    assert_selector "button[value='yes']"
    assert_selector "button[value='no']"
  end

  def test_renders_unsure_button_when_enabled
    render_inline(YesNoButtonsComponent.new(form: build_form, method: :text_field, unsure: true))
    assert_selector "button[value='unsure']"
  end

  def test_css_class_is_appended_to_root
    render_inline(YesNoButtonsComponent.new(form: build_form, method: :text_field, css_class: "mt-cfa-lg"))
    assert_selector "div.yes-no-buttons.mt-cfa-lg"
  end
end
