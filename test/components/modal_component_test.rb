# frozen_string_literal: true

require "test_helper"

class ModalComponentTest < ViewComponent::TestCase
  def test_renders_with_name_in_x_id
    render_inline(ModalComponent.new(name: "confirm"))
    assert_selector "div[x-id*='confirm-title']"
  end

  def test_renders_header_slot
    render_inline(ModalComponent.new(name: "confirm")) do |c|
      c.with_header { "Are you sure?" }
    end
    assert_selector "h2", text: "Are you sure?"
  end

  def test_renders_body_content
    render_inline(ModalComponent.new(name: "confirm")) { "This cannot be undone." }
    assert_text "This cannot be undone."
  end

  def test_renders_button_slots
    render_inline(ModalComponent.new(name: "confirm")) do |c|
      c.with_button { "Confirm" }
      c.with_button { "Cancel" }
    end
    assert_text "Confirm"
    assert_text "Cancel"
  end
end
