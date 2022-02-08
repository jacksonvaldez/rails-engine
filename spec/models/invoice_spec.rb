require 'rails_helper'

RSpec.describe Invoice do

  before(:each) do
    @customer = Customer.create!
    @merchant = Merchant.create!
    @invoice = Invoice.create!(customer_id: @customer.id, merchant_id: @merchant.id)
  end

  describe 'relationships' do
    it { should have_many(:invoice_items) }
    it { should have_many(:items).through(:invoice_items) }
  end

  it 'exists' do
    expect(@invoice).to be_a(Invoice)
  end

  it 'has attributes' do
    expect(@invoice.customer_id).to eq(@customer.id)
    expect(@invoice.merchant_id).to eq(@merchant.id)
  end
end
