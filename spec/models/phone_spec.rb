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

   it "does not allow duplicate phone numbers per contact" do
      contact = create(:contact)
      home_phone = create(:home_phone,
                           contact: contact,
                           phone: '785-555-1234')
      mobile_phone = build(:mobile_phone,
                            contact: contact,
                            phone: '785-555-1234')
    expect(mobile_phone).to_not have(1).errors_on(:phone)
end
end
