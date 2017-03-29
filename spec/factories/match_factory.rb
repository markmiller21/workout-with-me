FactoryGirl.define do
  factory :match do
    name  Faker::Name.name
    email Faker::Internet.email
    password  Faker::Internet.password
    age Faker::Number.between(15,45)
    gender "Female"
    description Faker::Lorem.word
  end
end