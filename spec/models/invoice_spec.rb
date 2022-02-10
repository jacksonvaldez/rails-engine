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

  describe '#item_count' do
    it 'returns the number of items for the invoice' do
      expect(@invoice.item_count).to eq(0)
    end
  end

  describe "::destroy_by_item_count" do
    it 'destroys invoices that dont have any items' do
      expect(Invoice.first).to be_a(Invoice)

      Invoice.destroy_by_item_count

      expect(Invoice.first).to eq(nil)
    end
    it 'doesnt destroy invoices that have items' do
      item = Item.create!(name: 'Name', description: 'Description', unit_price: 35, merchant_id: @merchant.id )
      ii = InvoiceItem.create!(invoice_id: @invoice.id, item_id: item.id)
      Invoice.destroy_by_item_count

      expect(Invoice.first).to be_a(Invoice)
    end
  end
end
