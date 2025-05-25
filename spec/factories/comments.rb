FactoryBot.define do
  factory :comment do
    body { Faker::Lorem.sentence }
    association :user
    association :project
  end
end
