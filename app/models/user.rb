class User < ActiveRecord::Base
	# validations
	validates(:email, presence: true,
										uniqueness: true,
										:format     => { :with => /\A[^@]+@[^@]+\z/}) # email regex
	validates :password_digest, presence: true
end
