require 'rails_helper'

RSpec.describe 'Items Index' do

  before(:each) do
    @merchant_1 = Merchant.create!
    7.times do
      Item.create!(name: 'Name', description: 'Description', unit_price: 35, merchant_id: @merchant_1.id )
    end
    @merchant_2 = Merchant.create!
    5.times do
      Item.create!(name: 'Name', description: 'Description', unit_price: 35, merchant_id: @merchant_2.id )
    end
  end

  it 'returns all items' do
    get '/api/v1/items'

    expect(response).to be_successful

    items = JSON.parse(response.body, symbolize_names: true)

    expect(items[:data].length).to eq(12)

    expect(items[:data].first[:id]).to be_a(String)
    expect(items[:data].first[:type]).to be_a(String)
    expect(items[:data].first[:type]).to eq('item')

    expect(items[:data].first[:attributes][:name]).to be_a(String)
    expect(items[:data].first[:attributes][:description]).to be_a(String)
    expect(items[:data].first[:attributes][:unit_price]).to be_a(Float)
    expect(items[:data].first[:attributes][:merchant_id]).to be_a(Integer)
  end

end
