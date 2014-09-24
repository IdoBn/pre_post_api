class User < ActiveRecord::Base
	# validations
	validates :email, presence: true
	validates :password_digest, presence: true
end
