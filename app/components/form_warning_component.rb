# frozen_string_literal: true

class FormWarningComponent < BaseComponent
  def initialize(warning_message:, small: false, css_class: nil)
    @warning_message = warning_message
    @small = small
    @css_class = css_class
  end

  def icon_size
    @small ? 16 : 24
  end
end
