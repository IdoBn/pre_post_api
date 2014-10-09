require 'rails_helper'

RSpec.describe Post, :type => :model do
	context "associations" do
		it { should belong_to(:user) }
		it { should have_many(:votes) }
	end
end
