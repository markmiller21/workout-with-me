FactoryGirl.define do
  factory :user do
    name  Faker::Name.name
    email Faker::Internet.email
    password  Faker::Internet.password
    age Faker::Number.between(15,45)
    gender "Female"
    description Faker::Lorem.word
  end

  factory :potential_user, class: User do
    name Faker::Name.name
    email Faker::Internet.email
    password Faker::Internet.password
    age Faker::Number.between(15,45)
    gender "Male"
    description Faker::Lorem.word
  end

  factory :unmatched_user, class: User do
    name Faker::Name.name
    email Faker::Internet.email
    password Faker::Internet.password
    age Faker::Number.between(15,45)
    gender "Female"
    description Faker::Lorem.word
  end
end