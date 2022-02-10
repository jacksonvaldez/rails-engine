require 'rails_helper'

RSpec.describe Item do

  before(:each) do
    @merchant = Merchant.create!
    @item = Item.create!(name: 'item-name', description: 'item-description', unit_price: 50.0, merchant_id: @merchant.id)
  end

  describe 'relationships' do
    it { should belong_to(:merchant) }
    it { should have_many(:invoice_items) }
    it { should have_many(:invoices).through(:invoice_items) }
  end

  describe 'validations' do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:description) }
    it { should validate_presence_of(:unit_price) }
  end

  it 'exists' do
    expect(@item).to be_a(Item)
  end

  it 'has attributes' do
    expect(@item.merchant_id).to eq(@merchant.id)
  end

  describe '#error_messages' do
    it 'returns an array of errors if model fails to save to database' do
      item = Item.create
      expect(item.error_messages).to be_a(Array)
    end
  end
end
