# Read about factories at https://github.com/thoughtbot/factory_girl
require 'ffaker'

FactoryGirl.define do
  factory :user do
    email Faker::Internet.email
    password_digest "$2a$04$exIZAvRl0zC.4w7XTQNUTu8ERZ5qIibamJuqeiCJWMSGCMseHnP3i"
  end
end
