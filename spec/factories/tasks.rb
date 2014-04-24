FactoryGirl.define do
  factory :task do
    title Faker::Name.title
    project
  end
end