class User < ActiveRecord::Base
	# validations
	validates(:email, presence: true,
										uniqueness: true,
										email: true)
	validates :password_digest, presence: true

	# authentication support
	has_secure_password

	def set_auth_token
    # return if self.auth_token.present?

    begin
      self.auth_token = SecureRandom.hex
    end while self.class.exists?(auth_token: self.auth_token)
  end
end
