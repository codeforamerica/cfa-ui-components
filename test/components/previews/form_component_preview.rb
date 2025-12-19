require "active_model"

class FormComponentPreview < ViewComponent::Preview
  include ActionView::Helpers::FormHelper
  include ActionView::Helpers::FormOptionsHelper

  private

  def form(model: TestModel.new)
    form_with url: "/", method: :post, model: model do |f|
      return f
    end
  end

  class TestModel
    include ActiveModel::Model
    include ActiveModel::Attributes

    attribute :first_name
    attribute :last_name
    attribute :pineapple_pizza_preference
    attribute :favorite_fruits
    attribute :my_date
    validates :first_name, presence: true
    validates :last_name, presence: true
    validates :pineapple_pizza_preference, presence: true
    validates :favorite_fruits, presence: true
    validates :my_date, presence: true
  end

  def self.yes_no_options
    [ OpenStruct.new(value: "yes", label: "Yes"),
     OpenStruct.new(value: "no", label: "No") ]
  end

  def self.fruit_options
    [ OpenStruct.new(value: "orange", label: "Orange"),
     OpenStruct.new(value: "banana", label: "Banana"),
     OpenStruct.new(value: "apple", label: "Apple") ]
  end
end
