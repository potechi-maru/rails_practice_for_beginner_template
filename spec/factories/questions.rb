FactoryBot.define do
  factory :question do
    title { "MyString" }
    body { "MyText" }
    solved { false }
    user { nil }
  end
end
