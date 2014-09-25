# Read about factories at https://github.com/thoughtbot/factory_girl
require 'ffaker'

FactoryGirl.define do
  factory :user do
    email Faker::Internet.email
    password '123456'
    password_confirmation '123456'
    # password_digest "$2a$04$exIZAvRl0zC.4w7XTQNUTu8ERZ5qIibamJuqeiCJWMSGCMseHnP3i"
    name Faker::Internet.user_name

    factory :user2 do
    	email Faker::Internet.email
    	name Faker::Internet.user_name
    end
  end
end
