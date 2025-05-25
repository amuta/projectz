FactoryBot.define do
  factory :project do
    sequence(:name) { |n| "Project \#{n}" }
    status { 0 }
  end
end