require 'rails_helper'

RSpec.describe Item do

  before(:each) do
    @merchant = Merchant.create!
    @item = Item.create!(merchant_id: @merchant.id)
  end

  describe 'relationships' do
    it { should belong_to(:merchant) }
    it { should have_many(:invoice_items) }
    it { should have_many(:invoices).through(:invoice_items) }
  end

  it 'exists' do
    expect(@item).to be_a(Item)
  end

  it 'has attributes' do
    expect(@item.merchant_id).to eq(@merchant.id)
  end
end
