require 'rails_helper'

RSpec.describe StockService, type: :service do
  before(:each) do
    @product1 = Product.create(title:'Product1', stock:10, description:"desc",short_description:"short",expiration:DateTime.now)
  end
  after(:each) do
    @product1.destroy
  end
  it "#get_stock should return the real stock of the product" do
    #TODO: preguntar como sacar la sesión id desde aquí
    #@session_id = session["session_id"];
    #@basket = ShoppingCartService.new @session_id
    #@basket.add_item(@product2.id,2)
    expect(@product1.stock).to eq 10
    #expect(@product2.stock).to eq 8
  end
  it "#update_stock should change the product stock" do
    stock_service = StockService.new @product1
    stock_service.update_stock 3
    expect(@product1.stock).to eq 7
  end
end
