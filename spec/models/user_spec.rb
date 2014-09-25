require 'rails_helper'

RSpec.describe User, :type => :model do
  subject(:user) { FactoryGirl.create(:user) }
 	context 'valid attributes' do
 		it { expect be_valid }

 		it { expect(FactoryGirl.build(:user, password_digest: nil)).to_not be_valid }
 		it { expect(FactoryGirl.build(:user, email: nil)).to_not be_valid }
 		it { expect(FactoryGirl.build(:user, email: user.email)).to_not be_valid	}
 		it { expect(FactoryGirl.build(:user, email: 'dodoAtGmailDotCom')).to_not be_valid }

 		it { should have_secure_password }

 		it { should validate_presence_of(:name) }
 		it { should validate_uniqueness_of(:name) }
 	end

 	context 'associations' do
 		it { should have_many(:friendships) }
 		it { should have_many(:friends) }
 		it { should have_many(:pending_friends) }
 	end

 	it '#set_auth_token' do
 		expect { user.set_auth_token }.to change{ user.auth_token }
 	end

 	it 'searches for a user' do
 		user1 = FactoryGirl.create(:user)
 		user2 = FactoryGirl.create(:user2)

 		expect(User.text_search(user1.name)).to include(user1)
 	end
end
