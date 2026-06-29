# frozen_string_literal: true

require "test_helper"

class ModalComponentTest < ViewComponent::TestCase
  def test_renders_native_dialog_keyed_by_name
    render_inline(ModalComponent.new(name: "confirm"))
    assert_selector "dialog#confirm[data-cfa-modal='confirm']"
  end

  def test_header_id_is_referenced_by_aria_labelledby
    render_inline(ModalComponent.new(name: "confirm")) do |c|
      c.with_header { "Are you sure?" }
    end
    assert_selector "dialog[aria-labelledby='confirm-title']"
    assert_selector "h1#confirm-title", text: "Are you sure?"
  end

  def test_renders_header_slot
    render_inline(ModalComponent.new(name: "confirm")) do |c|
      c.with_header { "Are you sure?" }
    end
    assert_selector "h1", text: "Are you sure?"
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
