class Post < ActiveRecord::Base
	belongs_to :user
	has_many :votes

	def votes_yes
		self.votes.select { |vote| vote.status == 'yes' }
	end

	def votes_no
		self.votes.select { |vote| vote.status == 'no' }
	end
end