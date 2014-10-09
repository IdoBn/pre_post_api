class Vote < ActiveRecord::Base
	# associations
	belongs_to :user
	belongs_to :post

	# validations
	validates :status, presence: true, format: /no|yes/

end
