# frozen_string_literal: true

class ModalComponent < BaseComponent
  renders_one :header
  renders_many :buttons

  def initialize(name:)
    @name = name
  end
end
