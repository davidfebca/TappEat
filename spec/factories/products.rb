FactoryGirl.define do
  factory :product do
    title "Example product"
    featured true
    description "description"
    short_description "short"
    expiration DateTime.now
  end
end
