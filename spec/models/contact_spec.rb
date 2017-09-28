require 'spec_helper'

RSpec.describe Contact, type: :model do
  it 'in valid with a firstname,lastname and email' do
#    contact = Contact.new(
#       firstname: 'A',
#       lastname: 'json',
#       email: 'tester@gmail.com'
#    )
    expect(create(:contact)).to be_valid
  end

  it 'is invalid without lastname' do
    expect(Contact.new(lastname:nil)).to_not have(1).errors_on(:lastname)
  end

  it 'is valid with a duplicate email address' do
    Contact.create(
      firstname:'Joe',lastname:'Tester',
      email: 'tester@gmail.com')
    contact = Contact.new(
      firstname: 'Jane', lastname:'Tester',
      email: 'tester@gmail.com')
      expect(contact).to_not have(1).errors_on(:email)
  end

  it 'returns a contact full name as a string' do
    contact = Contact.new(firstname: 'John' ,lastname:'Doe', email:'tester@gmail.com')
    expect(contact.name).to eq 'John Doe'
  end

  it 'returns a sorted array of result that match' do
    smith = Contact.create(firstname: 'John' ,lastname:'Smith',email:"jsmith@example.com")
    jones = Contact.create(firstname: 'Tim', lastname:'Jone', email:'tjones@example.com')
    johnson = Contact.create(firstname:'John',lastname:'Johnson', email:'jjohnson@example.com')
    expect(Contact.by_letter('J')).to eq [johnson, jones]
  end

  describe 'filter last name by letter' do
    before :each do
      @smith = Contact.create(firstname: 'John' ,lastname:'Smith',email:"jsmith@example.com")
      @jones = Contact.create(firstname: 'Tim', lastname:'Jone', email:'tjones@example.com')
      @johnson = Contact.create(firstname:'John',lastname:'Johnson', email:'jjohnson@example.com')
    end
    context "matching letter" do
      it "returns a sorted array of results that match " do
        expect(Contact.by_letter('J')).to eq [@johnson,@jones]
      end
    end

    context 'non-matching letter' do
      it 'only returns contacts with the provided starting letter' do
        expect(Contact.by_letter('J')).to_not include @smith
      end
    end

    it 'has a valid Factory' do
      expect(build(:contact)).to be_valid
    end
  end
end
