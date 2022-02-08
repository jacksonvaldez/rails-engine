require 'rails_helper'

RSpec.describe Customer do

  before(:each) do
    @customer = Customer.create!(first_name: 'First Name', last_name: 'Last Name')
  end

  it 'exists' do
    expect(@customer).to be_a(Customer)
  end

  it 'has attributes' do
    expect(@customer.first_name).to eq('First Name')
    expect(@customer.last_name).to eq('Last Name')
  end
end
