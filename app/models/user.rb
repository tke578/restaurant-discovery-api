class User < ApplicationRecord
	has_secure_password 
	validates_format_of :email, with: /\A[^@\s]+@([^@\s]+\.)+[^@\s]+\z/, presence: true
	validates :email, uniqueness: true
	
	has_many :favorite_locations,  dependent: :destroy


end
