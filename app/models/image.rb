class Image < ActiveRecord::Base
  has_one :product
  has_one :user
  has_one :category
  has_attached_file :original, styles: { medium: "300x300>", thumb: "100x100>" }, default_url: "/images/noPicture.png"
  validates_attachment_content_type :original, content_type: /\Aimage\/.*\Z/
end
