FactoryGirl.define do
  factory :user do
    name  Faker::Name.name
    email Faker::Internet.email
    password  Faker::Internet.password
    age Faker::Number.between(15,100)
    gender "Female"
    description Faker::Lorem.word
  end
end