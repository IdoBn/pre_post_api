# Read about factories at https://github.com/thoughtbot/factory_girl
require 'ffaker'

FactoryGirl.define do
  factory :user do
    email Faker::Internet.email
    password_digest "MyString"
  end
end
