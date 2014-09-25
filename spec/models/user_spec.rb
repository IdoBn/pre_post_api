require 'rails_helper'

RSpec.describe User, :type => :model do
  subject(:user) { FactoryGirl.create(:user) }
 	context 'valid attributes' do
 		it { expect be_valid }

 		it { expect(FactoryGirl.build(:user, password_digest: nil)).to_not be_valid }
 		it { expect(FactoryGirl.build(:user, email: nil)).to_not be_valid }
 		it { expect(FactoryGirl.build(:user, email: user.email)).to_not be_valid	}
 		it { expect(FactoryGirl.build(:user, email: 'dodoAtGmailDotCom')).to_not be_valid }
 	end

 	it '#set_auth_token' do
 		expect { user.set_auth_token }.to change{ user.auth_token.class }.from(NilClass).to(String)
 	end
end
