class User < ActiveRecord::Base
	# assocations
	has_many :friendships
	has_many :friends, -> { where(friendships: { status: 'accepted' }) }, through: :friendships
	has_many :pending_friends,
		-> { where(friendships: { status: 'pending' }) },
		through: :friendships,
		source: :friend
	has_many :friend_requests,
		-> { where(friendships: { status: 'requested' }) },
		through: :friendships,
		source: :friend

	# validations
	validates(:email, presence: true,
										uniqueness: true,
										email: true)
	validates :password_digest, presence: true
	validates :name, presence: true, 
									 uniqueness: true, 
									 format: { with: /\A[a-zA-Z0-9._-]+\Z/ }

	# authentication support
	has_secure_password

	# callbacks
	before_create :set_auth_token

	def set_auth_token
    begin
      self.auth_token = SecureRandom.hex
    end while self.class.exists?(auth_token: self.auth_token)
  end

  def self.text_search(query)
  	if query.present?
  		where("name @@ :q", q: query)
  	else
  		scoped
  	end
  end
end
