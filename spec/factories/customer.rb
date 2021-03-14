FactoryBot.define do
    factory :customer do
        first_name { Faker::Name.last_name }
        last_name { Faker::Name.first_name }
        email { Faker::Internet.email }
        age { Faker::Number.within(range: 18..80) }
        gender { Faker::Gender.binary_type }
        phone { Faker::PhoneNumber.cell_phone }
    end
end