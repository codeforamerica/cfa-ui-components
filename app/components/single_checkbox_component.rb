# frozen_string_literal: true

class SingleCheckboxComponent < ViewComponent::Base
  def initialize(form:, method:, label:, checked: nil, disabled: false, required: false)
    @form = form
    @method = method
    @label = label
    @checked = checked
    @disabled = disabled
  end
end
