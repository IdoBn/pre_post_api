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
 	end

 	context 'associations' do
 		it { should have_many(:friendships) }
 		it { should have_many(:friends) }
 		it { should have_many(:pending_friends) }
 	end

 	it '#set_auth_token' do
 		expect { user.set_auth_token }.to change{ user.auth_token }
 	end
end
