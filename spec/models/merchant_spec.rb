require 'rails_helper'

RSpec.describe Merchant do

  before(:each) do
    @merchant_1 = Merchant.create!(name: 'Another Name')
    @merchant_2 = Merchant.create!(name: 'Turing')
    @merchant_3 = Merchant.create!(name: 'The Ring')
    @merchant_4 = Merchant.create!(name: 'Some Name')
    @merchant_5 = Merchant.create!(name: 'namesome')
    @merchant_6 = Merchant.create!(name: 'nAmE')
    @merchant_7 = Merchant.create!(name: 'lAlE')
  end

  describe 'relationships' do
    it { should have_many(:items) }
  end

  it 'exists' do
    expect(@merchant_1).to be_a(Merchant)
  end

  describe '::order_by_name' do
    it 'orders merchants by name' do
      expect(Merchant.order_by_name).to eq([@merchant_1, @merchant_7, @merchant_6, @merchant_5, @merchant_4, @merchant_3, @merchant_2])
    end
  end

  describe '::search_by_name' do
    it 'returns merchants based on search case #1' do
      merchants = Merchant.search_by_name('rInG')

      expect(merchants.include?(@merchant_2)).to eq(true)
      expect(merchants.include?(@merchant_3)).to eq(true)
    end
    it 'returns merchants based on search case #2' do
      merchants = Merchant.search_by_name('NAME')

      expect(merchants.length).to eq(4)
    end
    it 'returns merchants based on search case #2' do
      merchants = Merchant.search_by_name('NAMEEEE')

      expect(merchants.length).to eq(0)
    end
  end


end
