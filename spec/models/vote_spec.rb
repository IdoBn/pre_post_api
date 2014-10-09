require 'rails_helper'

RSpec.describe Vote, :type => :model do
	context 'validations' do
		it { should validate_presence_of(:status) }
		it { expect(FactoryGirl.build(:vote, status: 'no')).to be_valid }
		it { expect(FactoryGirl.build(:vote, status: 'yes')).to be_valid }
		it { expect(FactoryGirl.build(:vote, status: 'dodo')).to_not be_valid }
	end

	context 'associations' do
		it { should belong_to(:user) }
		it { should belong_to(:post) }
	end
end
