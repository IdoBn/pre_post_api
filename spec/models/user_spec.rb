require 'rails_helper'

RSpec.describe User, :type => :model do
  # pending "add some examples to (or delete) #{__FILE__}"
 	context 'valid attributes' do
 		subject(:user) { FactoryGirl.create(:user) }

 		it { expect be_valid }

 		it { expect(FactoryGirl.build(:user, password_digest: nil)).to_not be_valid }
 		it { expect(FactoryGirl.build(:user, email: nil)).to_not be_valid }
 	end
end
