require 'rails_helper'

RSpec.describe InvoiceItem do

  before(:each) do
    @merchant = Merchant.create!
    @item = Item.create!(merchant_id: @merchant.id)
    @invoice = Invoice.create!
    @ii = InvoiceItem.create!(invoice_id: @invoice.id, item_id: @item.id ) # arbitrary ids
  end

  describe 'relationships' do
    it { should belong_to(:invoice) }
    it { should belong_to(:item) }
  end

  it 'exists' do
    expect(@ii).to be_a(InvoiceItem)
  end

  it 'has attributes' do
    expect(@ii.invoice_id).to eq(@invoice.id)
    expect(@ii.item_id).to eq(@item.id)
  end
end
