FactoryBot.define do
  factory :blog do
    title { 'Sample Blog' }
    content { 'Sample content' }
    association :user
  end
end