require 'rails_helper'

RSpec.describe Testimonial, type: :model do
  before(:each) do
    @testimonial = Testimonial.create(content: 'example content')
  end
  after(:each) do
    @testimonial.destroy
  end
  it "#get_random should return a list of random testimonials" do
    testimonials = Testimonial.get_random 1
    expect(testimonials.length).to eq 1
  end
end
