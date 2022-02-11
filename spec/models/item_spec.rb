require 'rails_helper'

RSpec.describe Item do

  before(:each) do
    @merchant = Merchant.create!

    @item_1 = Item.create!(name: 'Another Name', description: 'item-description', unit_price: 50.0, merchant_id: @merchant.id)
    @item_2 = Item.create!(name: 'Turing', description: 'item-description', unit_price: 50.0, merchant_id: @merchant.id)
    @item_3 = Item.create!(name: 'The Ring', description: 'item-description', unit_price: 50.0, merchant_id: @merchant.id)
    @item_4 = Item.create!(name: 'Some Name', description: 'item-description', unit_price: 50.0, merchant_id: @merchant.id)
    @item_5 = Item.create!(name: 'namesome', description: 'item-description', unit_price: 50.0, merchant_id: @merchant.id)
    @item_6 = Item.create!(name: 'nAmE', description: 'item-description', unit_price: 50.0, merchant_id: @merchant.id)
    @item_7 = Item.create!(name: 'lAlE', description: 'item-description', unit_price: 50.0, merchant_id: @merchant.id)
  end

  describe 'relationships' do
    it { should belong_to(:merchant) }
    it { should have_many(:invoice_items).dependent(:delete_all) }
    it { should have_many(:invoices).through(:invoice_items) }
  end

  describe 'validations' do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:description) }
    it { should validate_presence_of(:unit_price) }
  end

  it 'exists' do
    expect(@item_1).to be_a(Item)
  end

  it 'has attributes' do
    expect(@item_1.merchant_id).to eq(@merchant.id)
  end

  describe '#error_messages' do
    it 'returns an array of errors if model fails to save to database' do
      item = Item.create
      expect(item.error_messages).to be_a(Array)
    end
  end

  describe '::order_by_name' do
    it 'orders items by name' do
      expect(Item.order_by_name).to eq([@item_1, @item_7, @item_6, @item_5, @item_4, @item_3, @item_2])
    end
  end

  describe '::search_by_name' do
    it 'returns items based on search case #1' do
      items = Item.search_by_name('rInG')

      expect(items.include?(@item_2)).to eq(true)
      expect(items.include?(@item_3)).to eq(true)
    end
    it 'returns items based on search case #2' do
      items = Item.search_by_name('NAME')

      expect(items.length).to eq(4)
    end
    it 'returns items based on search case #2' do
      items = Item.search_by_name('NAMEEEE')

      expect(items.length).to eq(0)
    end
  end
end
