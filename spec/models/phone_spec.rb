require 'spec_helper'

describe Phone do
  it "does not allow duplicate phone numbers per contact" do
    contact = create(:contact)
    create(:home_phone, contact: contact, phone: "785-555-1234")
    mobile_phone = build(:mobile_phone, contact: contact, phone: "785-555-1234")
    expect(mobile_phone).to have(1).errors_on(:phone)
  end

  it "allows two contacts to share a phone number" do
    contact = Contact.create(firstname: 'Joe', lastname: 'Tester',
      email: 'joetester@example.com')
    contact.phones.create(phone_type: 'home',
      phone: '785-555-1234')
    other_contact = Contact.new
    other_phone = other_contact.phones.build(phone_type:
      'home', phone: '785-555-1234')

    expect(other_phone).to be_valid
  end
end