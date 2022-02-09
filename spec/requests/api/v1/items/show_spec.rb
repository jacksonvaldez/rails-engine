require 'rails_helper'

RSpec.describe 'Get A Single Item' do

  before(:each) do
    merchant = Merchant.create!
    8.times do
      Item.create!(name: 'Name', description: 'Description', unit_price: 35, merchant_id: merchant.id)
    end
    @last_item = Item.last
  end

  it 'returns a single item' do
    get "/api/v1/items/#{@last_item.id}"

    expect(response).to be_successful

    item = JSON.parse(response.body, symbolize_names: true)

    expect(item[:data][:id]).to be_a(String)
    expect(item[:data][:type]).to be_a(String)
    expect(item[:data][:type]).to eq('item')

    expect(item[:data][:attributes][:name]).to be_a(String)
    expect(item[:data][:attributes][:description]).to be_a(String)
    expect(item[:data][:attributes][:unit_price]).to be_a(Float)
    expect(item[:data][:attributes][:merchant_id]).to be_a(Integer)
  end

  it 'returns error if given item id is invalid or not an integer' do
    get "/api/v1/items/invalid_id"

    expect(response.status).to eq(404)
    expect(response).to_not be_successful

    item = JSON.parse(response.body, symbolize_names: true)

    expect(item[:message]).to be_a(String)
    expect(item[:message]).to eq("invalid item id")
  end

end
