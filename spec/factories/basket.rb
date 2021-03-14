FactoryBot.define do
    factory :basket do
        customer { create(:customer) }
    end
end