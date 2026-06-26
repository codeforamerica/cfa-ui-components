ENV["RAILS_ENV"] ||= "test"
require_relative "../config/environment"
require "rails/test_help"
require "active_model"

class ComponentTestModel
  include ActiveModel::Model
  include ActiveModel::Attributes

  attribute :text_field
  attribute :checkbox_field
  attribute :radio_field
  attribute :select_field
  attribute :combobox_field
  attribute :checkboxes_field
  attribute :my_date
end

module FormBuildable
  def build_form(model = ComponentTestModel.new)
    f = nil
    vc_test_controller.view_context.form_with(url: "/", model:) { |fb| f = fb }
    f
  end

  def simple_collection
    [
      OpenStruct.new(value: "yes", label: "Yes"),
      OpenStruct.new(value: "no", label: "No")
    ]
  end
end

ViewComponent::TestCase.include(FormBuildable)

module ActiveSupport
  class TestCase
    parallelize(workers: :number_of_processors)
  end
end
