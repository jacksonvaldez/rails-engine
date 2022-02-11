require 'rails_helper'

RSpec.describe 'Get A Single Merchant By Item' do

  before(:each) do
    5.times do
      Merchant.create!(name: Faker::Name.name)
    end
    @last_merchant = Merchant.last
    @other_merchant = Merchant.all[2]

    @item = Item.create!(name: 'item-name', description: 'item-description', unit_price: 40, merchant_id: @other_merchant.id)
  end

  it 'returns the merchant for a specific item' do
    get "/api/v1/items/#{@item.id}/merchant"

    expect(response).to be_successful

    merchant = JSON.parse(response.body, symbolize_names: true)

    expect(merchant[:data][:id]).to be_a(String)
    expect(merchant[:data][:id]).to eq("#{@other_merchant.id}")
    expect(merchant[:data][:type]).to be_a(String)
    expect(merchant[:data][:type]).to eq('merchant')

    expect(merchant[:data][:attributes][:name]).to be_a(String)
    expect(merchant[:data][:attributes][:name]).to eq(@other_merchant.name)
  end

  describe 'sad path and edge cases' do
    it 'returns error if item id does not exist' do
      get "/api/v1/items/23357346/merchant"

      expect(response.status).to eq(404)
      expect(response).to_not be_successful

      merchant = JSON.parse(response.body, symbolize_names: true)

      expect(merchant[:message]).to be_a(String)
      expect(merchant[:message]).to eq("your query could not be completed")
      expect(merchant[:errors]).to be_a(Array)
    end

    it 'returns error if item id is invalid' do
      get "/api/v1/items/invalid_item_id/merchant"

      expect(response.status).to eq(404)
      expect(response).to_not be_successful

      merchant = JSON.parse(response.body, symbolize_names: true)

      expect(merchant[:message]).to be_a(String)
      expect(merchant[:message]).to eq("your query could not be completed")
      expect(merchant[:errors]).to be_a(Array)
    end
  end

end
