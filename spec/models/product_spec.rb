require 'rails_helper'

RSpec.describe Product, type: :model do
    before(:each) do
      FactoryGirl.create(:product)
    end
    it "#get_random_featured should return a list of featured products" do
      products = Product.get_random_featured 1
      expect(products.first).to have_attributes(:featured=>true)
      expect(products.length).to eq(1)
    end
    it "#search_near should return products near a certain point" do
      lat1 = Place.create(lat:0.72218230298, lng:0.037453561471)
      lat2 = Place.create(lat:0.72215659428, lng:0.037451868501)
      product1 = Product.create(title:'Product1',place:lat1, description:"desc",short_description:"short",expiration:DateTime.now)
      product2 = Product.create(title:'Product2',place:lat2, description:"desc",short_description:"short",expiration:DateTime.now)
      lat = 0.72218917958
      lng= 0.037444381039
      products = Product.search_near lat, lng
      productok = products.select do |product|
        product[0].title = "Product1"
      end.first
      productok2 = products.select do |product|
        product[0].title = "Product2"
      end.first
      expect(products).to include(productok)
      expect(products).to include(productok2)
    end
    it "#get_random_by_category should return a list with products of the category" do
      category1 = Category.create(name:"Category 1")
      category2 = Category.create(name:"Category 2")
      product1 = Product.create(title:'Product1',category:category1, description:"desc",short_description:"short",expiration:DateTime.now)
      product2 = Product.create(title:'Product2', category:category1, description:"desc",short_description:"short",expiration:DateTime.now)
      product3 = Product.create(title:'Product2', category:category2, description:"desc",short_description:"short",expiration:DateTime.now)
      products = Product.get_random_by_category category1.id, 2
      expect(products).to include(product1)
      expect(products).to include(product2)
      expect(products).not_to include(product3)
      expect(products.length).to eq(2)

    end
end
