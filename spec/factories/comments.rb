FactoryBot.define do
  factory :comment do
    content { 'Sample content' }
    association :user
    association :blog
  end
end