require 'rails_helper'

RSpec.describe User, :type => :model do
  # pending "add some examples to (or delete) #{__FILE__}"
 	context 'valid attributes' do
 		subject(:user) { FactoryGirl.create(:user) }
 		let(:invalid_user) { User.create() }

 		it { should be_valid }

 		it { invalid_user.should_not be_valid }
 	end
end
