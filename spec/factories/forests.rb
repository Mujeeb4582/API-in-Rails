FactoryBot.define do
  factory :forest do
    name { Faker::Name.name }
    state { Faker::Address.state }
  end
end
