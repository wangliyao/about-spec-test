require 'spec_helper'

RSpec.describe Phone, type: :model do
   it 'allows two contacts to share a phone number' do
     create(:phone,
            phone_type: "home",
            phone: "12345679")
      expect(build(:phone,
             phone_type: 'home',
             phone:"12345679")).to be_valid
   end
end
