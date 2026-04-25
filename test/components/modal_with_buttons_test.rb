# frozen_string_literal: true

require "test_helper"

# Tests that ModalComponent correctly composes with ButtonLinkComponent
# in its button slots.
class ModalWithButtonsTest < ViewComponent::TestCase
  def test_modal_renders_button_link_components_in_slots
    render_inline(ModalComponent.new(name: "confirm")) do |modal|
      modal.with_header { "Are you sure?" }
      modal.with_button do
        vc_test_controller.view_context.render(ButtonLinkComponent.new(label: "Confirm", url: "/confirm", variant: :primary))
      end
      modal.with_button do
        vc_test_controller.view_context.render(ButtonLinkComponent.new(label: "Cancel", url: "#", variant: :secondary))
      end
      "This action cannot be undone."
    end

    assert_selector "dialog"
    assert_selector "h2", text: "Are you sure?"
    assert_text "This action cannot be undone."
    assert_link "Confirm"
    assert_link "Cancel"
    assert_selector "a.btn--primary"
    assert_selector "a.btn--secondary"
  end

  def test_modal_renders_submit_button_in_slot
    render_inline(ModalComponent.new(name: "confirm")) do |modal|
      modal.with_header { "Submit form?" }
      modal.with_button do
        vc_test_controller.view_context.render(SubmitButtonComponent.new(form: build_form, label: "Submit"))
      end
      "Please review before submitting."
    end

    assert_selector "dialog"
    assert_selector "input[type='submit'][value='Submit']"
  end
end
