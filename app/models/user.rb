class User < ActiveRecord::Base
	# validations
	validates(:email, presence: true,
										uniqueness: true,
										email: true)
	validates :password_digest, presence: true

	# authentication support
	has_secure_password
end
