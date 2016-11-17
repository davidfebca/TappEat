class User < ActiveRecord::Base
  include ActiveModel::Validations
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  belongs_to :place
  has_many :images
  has_many :products
  has_many :testimonials
  has_many :purchases
  validates :name, :presence => true
  validates :email, :presence => true
end
