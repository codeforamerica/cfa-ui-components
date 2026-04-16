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
    attribute :my_number
    validates :first_name, presence: true
    validates :last_name, presence: true
    validates :pineapple_pizza_preference, presence: true
    validates :favorite_fruits, presence: true
    validates :my_date, presence: true
    validates :my_number, presence: true
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

  def self.combobox_fruit_options
    [ OpenStruct.new(value: "apple", label: "Apple"),
    OpenStruct.new(value: "apricot", label: "Apricot"),
    OpenStruct.new(value: "avocado", label: "Avocado"),
    OpenStruct.new(value: "banana", label: "Banana"),
    OpenStruct.new(value: "blackberry", label: "Blackberry"),
    OpenStruct.new(value: "blood orange", label: "Blood orange"),
    OpenStruct.new(value: "blueberry", label: "Blueberry"),
    OpenStruct.new(value: "boysenberry", label: "Boysenberry"),
    OpenStruct.new(value: "breadfruit", label: "Breadfruit"),
    OpenStruct.new(value: "buddhas hand citron", label: "Buddha's hand citron"),
    OpenStruct.new(value: "cantaloupe", label: "Cantaloupe"),
    OpenStruct.new(value: "clementine", label: "Clementine"),
    OpenStruct.new(value: "crab apple", label: "Crab apple"),
    OpenStruct.new(value: "currant", label: "Currant"),
    OpenStruct.new(value: "cherry", label: "Cherry"),
    OpenStruct.new(value: "custard apple", label: "Custard apple"),
    OpenStruct.new(value: "coconut", label: "Coconut"),
    OpenStruct.new(value: "cranberry", label: "Cranberry"),
    OpenStruct.new(value: "date", label: "Date"),
    OpenStruct.new(value: "dragonfruit", label: "Dragonfruit"),
    OpenStruct.new(value: "durian", label: "Durian"),
    OpenStruct.new(value: "elderberry", label: "Elderberry"),
    OpenStruct.new(value: "fig", label: "Fig"),
    OpenStruct.new(value: "gooseberry", label: "Gooseberry"),
    OpenStruct.new(value: "grape", label: "Grape"),
    OpenStruct.new(value: "grapefruit", label: "Grapefruit"),
    OpenStruct.new(value: "guava", label: "Guava"),
    OpenStruct.new(value: "honeydew melon", label: "Honeydew melon"),
    OpenStruct.new(value: "jackfruit", label: "Jackfruit"),
    OpenStruct.new(value: "kiwifruit", label: "Kiwifruit"),
    OpenStruct.new(value: "kumquat", label: "Kumquat"),
    OpenStruct.new(value: "lemon", label: "Lemon"),
    OpenStruct.new(value: "lime", label: "Lime"),
    OpenStruct.new(value: "lychee", label: "Lychee"),
    OpenStruct.new(value: "mandarine", label: "Mandarine"),
    OpenStruct.new(value: "mango", label: "Mango"),
    OpenStruct.new(value: "mangosteen", label: "Mangosteen"),
    OpenStruct.new(value: "marionberry", label: "Marionberry"),
    OpenStruct.new(value: "nectarine", label: "Nectarine"),
    OpenStruct.new(value: "orange", label: "Orange"),
    OpenStruct.new(value: "papaya", label: "Papaya"),
    OpenStruct.new(value: "passionfruit", label: "Passionfruit"),
    OpenStruct.new(value: "peach", label: "Peach"),
    OpenStruct.new(value: "pear", label: "Pear"),
    OpenStruct.new(value: "persimmon", label: "Persimmon"),
    OpenStruct.new(value: "plantain", label: "Plantain"),
    OpenStruct.new(value: "plum", label: "Plum"),
    OpenStruct.new(value: "pineapple", label: "Pineapple"),
    OpenStruct.new(value: "pluot", label: "Pluot"),
    OpenStruct.new(value: "pomegranate", label: "Pomegranate"),
    OpenStruct.new(value: "pomelo", label: "Pomelo"),
    OpenStruct.new(value: "quince", label: "Quince"),
    OpenStruct.new(value: "raspberry", label: "Raspberry"),
    OpenStruct.new(value: "rambutan", label: "Rambutan"),
    OpenStruct.new(value: "soursop", label: "Soursop"),
    OpenStruct.new(value: "starfruit", label: "Starfruit"),
    OpenStruct.new(value: "strawberry", label: "Strawberry"),
    OpenStruct.new(value: "tamarind", label: "Tamarind"),
    OpenStruct.new(value: "tangelo", label: "Tangelo"),
    OpenStruct.new(value: "tangerine", label: "Tangerine"),
    OpenStruct.new(value: "ugli fruit", label: "Ugli fruit"),
    OpenStruct.new(value: "watermelon", label: "Watermelon"),
    OpenStruct.new(value: "yuzu", label: "Yuzu"),
    OpenStruct.new(value: "white currant", label: "White currant") ]
  end
end
