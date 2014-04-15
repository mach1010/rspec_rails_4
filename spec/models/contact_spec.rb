require 'spec_helper'

describe Contact do
  
  it 'should be invalid with invalid first name' do
    contact = Contact.new(firstname: nil)
    expect(contact).to have(1).error_on(:firstname)
  end
end
