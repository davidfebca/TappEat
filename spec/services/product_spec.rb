require 'rails_helper'

RSpec.describe ProductService, type: :service do
  before(:each) do
    @product1 = Product.create(title:'Product1', stock:10, description:"desc",short_description:"short",expiration:DateTime.now)
  end
  after(:each) do
    @product1.destroy
  end
  it "#update_product should update product properly" do
    user = User.create(name:"David Febrer Cardona",email:"david.febca@example.com",rating: 5,
                password:"ironhack",password_confirmation:"ironhack")
    params = {id:"",title:"prova",short_description:"short",description:"desc",price:10,expiration:DateTime.now,stock:10}
    new_product = ProductService.update_product user.id, params
    expect(new_product.title).to eq "prova"
    expect(new_product.short_description).to eq "short"
    expect(new_product.description).to eq "desc"
    expect(new_product.price).to eq 10
    expect(new_product.stock).to eq 10
  end
  it "#delete should delete the product" do
    product1 = Product.create(title:'Product1', stock:10, description:"desc",short_description:"short",expiration:DateTime.now)
    ProductService.delete product1.id
    products = Product.all
    expect(products).not_to include(product1)

  end
end
