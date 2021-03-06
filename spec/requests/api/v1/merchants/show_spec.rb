require 'rails_helper'

RSpec.describe 'Get A Single Merchant' do

  before(:each) do
    5.times do
      Merchant.create!(name: Faker::Name.name)
    end
    @last_merchant = Merchant.last
    @other_merchant = Merchant.all[2]

    @item = Item.create!(name: 'item-name', description: 'item-description', unit_price: 40, merchant_id: @other_merchant.id)
  end

  it 'returns a single merchant' do
    get "/api/v1/merchants/#{@last_merchant.id}"

    expect(response).to be_successful

    merchant = JSON.parse(response.body, symbolize_names: true)

    expect(merchant[:data][:id]).to be_a(String)
    expect(merchant[:data][:type]).to be_a(String)
    expect(merchant[:data][:type]).to eq('merchant')

    expect(merchant[:data][:attributes][:name]).to be_a(String)
  end

  describe 'sad paths and edge cases' do
    it 'returns error if given merchant id is invalid or not an integer' do
      get "/api/v1/merchants/invalid_id"

      expect(response.status).to eq(404)
      expect(response).to_not be_successful

      merchant = JSON.parse(response.body, symbolize_names: true)

      expect(merchant[:message]).to be_a(String)
      expect(merchant[:message]).to eq("your query could not be completed")
      expect(merchant[:errors]).to be_a(Array)
    end
  end

end
