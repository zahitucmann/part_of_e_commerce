FactoryBot.define do
    factory :order do
        customer { create(:customer) }
    end
end