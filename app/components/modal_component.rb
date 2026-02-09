# frozen_string_literal: true

class ModalComponent < BaseComponent
  renders_one :header

  def initialize(name:)
    @name = name
  end
end
