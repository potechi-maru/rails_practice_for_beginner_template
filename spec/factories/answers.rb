FactoryBot.define do
  factory :answer do
    body { "MyText" }
    user { nil }
    question { nil }
  end
end
