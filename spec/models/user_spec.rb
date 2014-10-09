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

 		it { should ensure_length_of(6..40) }

 		it 'should not be valid with short password' do
 			user = User.new email: 'something@gmail.com', password: '12345', password_confirmation: '12345', name: 'something'
 			expect(user).to_not be_valid
 		end

 		it 'should not be valid with a confirmation mismatch' do
 			user = User.new email: 'something@gmail.com', password: '12345', password_confirmation: '123456', name: 'something'
 			expect(user).to_not be_valid
 		end

 		context "on an existing user" do
      let(:user) do
        u = User.create email: 'something@gmail.com', name: 'something', password: 'password', password_confirmation: 'password'
        User.find u.id
      end
 
      it "should be valid with no changes" do
        expect(user).to be_valid
      end
 
      it "should not be valid with an empty password" do
        user.password = user.password_confirmation = nil
        expect(user).to_not be_valid
      end
 
      it "should be valid with a new (valid) password" do
        user.password = user.password_confirmation = "new password"
        expect(user).to be_valid
      end
    end
 	end

 	context 'associations' do
 		it { should have_many(:friendships) }
 		it { should have_many(:friends) }
 		it { should have_many(:pending_friends) }
    it { should have_many(:posts) }
    it { should have_many(:votes) }
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
