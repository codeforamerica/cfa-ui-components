# frozen_string_literal: true

class SingleCheckboxComponentPreview < FormComponentPreview
  def default
    render SingleCheckboxComponent.new(
      form: form,
      method: :agree,
      label: "Default"
    )
  end

  def prefilled
    render SingleCheckboxComponent.new(
      form: form,
      method: :agree,
      label: "Prefilled",
      checked: true
    )
  end

  def with_error
    custom_model = self.class::TestModel.new
    custom_model.valid?

    render SingleCheckboxComponent.new(
      form: form(model: custom_model),
      method: :pineapple_pizza_preference,
      label: "With errors"
    )
  end

  def unselectable
    render SingleCheckboxComponent.new(
      form: form,
      method: :agree,
      label: "Unselectable",
      disabled: true
    )
  end
end
