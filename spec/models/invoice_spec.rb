require 'rails_helper'

RSpec.describe Invoice do

  before(:each) do
    @customer = Customer.create!
    @merchant = Merchant.create!
    @invoice = Invoice.create!(customer_id: @customer.id, merchant_id: @merchant.id)
  end

  describe 'relationships' do
    it { should have_many(:invoice_items).dependent(:delete_all) }
    it { should have_many(:items).through(:invoice_items) }
  end

  it 'exists' do
    expect(@invoice).to be_a(Invoice)
  end

  it 'has attributes' do
    expect(@invoice.customer_id).to eq(@customer.id)
    expect(@invoice.merchant_id).to eq(@merchant.id)
  end

  describe "::with_no_items" do
    it 'selects invoices that dont have any items' do
      expect(Invoice.with_no_items.length).to eq(1)
    end
    it 'doesnt select invoices that have items' do
      item = Item.create!(name: 'Name', description: 'Description', unit_price: 35, merchant_id: @merchant.id )
      ii = InvoiceItem.create!(invoice_id: @invoice.id, item_id: item.id)

      expect(Invoice.with_no_items.length).to eq(0)
    end
  end
end
