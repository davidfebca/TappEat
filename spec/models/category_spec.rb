require 'rails_helper'

RSpec.describe Category, type: :model do
  before(:each) do
    @category = Category.create(name: 'example category')
  end
  after(:each) do
    @category.destroy
  end
  it "#get_random should return a list of random categories" do
    categories = Category.get_random 1
    expect(categories.length).to eq 1
  end
end
