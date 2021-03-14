require "rails_helper"

describe Customer, type: :model do
    # Relations
    it { should have_many(:baskets) }
    it { should have_many(:orders) }

    # Validations
    it { should validate_presence_of(:first_name) }
    it { should validate_presence_of(:last_name) }
    it { should validate_presence_of(:email) }
    it { should validate_presence_of(:phone) }
end