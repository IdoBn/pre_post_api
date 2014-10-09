class Vote < ActiveRecord::Base
	# associations
	belongs_to :user
	belongs_to :post

	# validations
	validates :status, presence: true,
										 format: /no|yes/										 
	validates_uniqueness_of :user_id, :scope => :post_id

end
