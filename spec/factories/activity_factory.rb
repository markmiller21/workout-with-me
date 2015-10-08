FactoryGirl.define do
  factory :activity do
    name  Faker::Name.name
    image Faker::Avatar.image
  end
end