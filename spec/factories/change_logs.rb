FactoryBot.define do
  factory :change_log do
    association :user
    association :recordable, factory: :project
    changed_data { { title: 'New Title', description: 'Updated description' } }
  end
end
