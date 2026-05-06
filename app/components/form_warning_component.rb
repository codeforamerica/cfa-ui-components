# frozen_string_literal: true

class FormWarningComponent < BaseComponent
  def initialize(warning_message:, small: false)
    @warning_message = warning_message
    @small = small
  end

  def icon_size
    @small ? 16 : 24
  end
end
