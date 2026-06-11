# frozen_string_literal: true

class FormWarningComponent < BaseComponent
  def initialize(warning_message:, small: false, id: nil)
    @warning_message = warning_message
    @small = small
    @id = id
  end

  def icon_size
    @small ? 16 : 24
  end
end
