class Product < ActiveRecord::Base

  belongs_to :user
  belongs_to :category
  belongs_to :place
  belongs_to :purchase
  has_many :comments
  has_many :images
  validates :title, presence: true
  validates :short_description, presence: true
  validates :price, presence: true
  validates :expiration, presence: true
  validates :stock, presence: true
  validates :description, presence: true

  def self.get_random_featured quantity
    limit(quantity).where('featured = true').order("RANDOM()")
  end

  def self.search_near lat, lng
    @products = []
    places = Place.where("acos(sin(#{lat}) * sin(lat) + cos(#{lat}) * cos(lat) * cos(lng - (#{lng}))) * 6371 <= 3").order("created_at DESC")
    places.each do |place|
      @products.push(place.products)
    end
    @products
  end

  def self.get_random_by_category categoryId, quantity
    limit(quantity).where("category_id = #{categoryId}").order("RANDOM()")
  end

  def by_user user_id
    where("user_id = ?", user_id)
  end
  
end
