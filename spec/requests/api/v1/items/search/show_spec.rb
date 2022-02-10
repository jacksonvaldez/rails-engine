require 'rails_helper'

RSpec.describe 'Finds Many Items based on search query' do
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

  it 'returns item based on query' do
    get '/api/v1/items/find_all?name=nAmE'

    items = JSON.parse(response.body, symbolize_names: true)

    expect(items[:data].length).to eq(4)
  end

  describe 'sad path and edge cases' do
    it 'doesnt return item if nothing matches the qeury' do
      get '/api/v1/items/find_all?name=NOMATCH'

      items = JSON.parse(response.body, symbolize_names: true)

      expect(items[:data].length).to eq(0)
    end
    it 'returns error if the query is blank' do
      get '/api/v1/items/find_all?name='

      items = JSON.parse(response.body, symbolize_names: true)
      expect(items[:message]).to eq("your query could not be completed")
      expect(items[:error]).to eq("name query is either missing or blank")

      expect(response).to_not be_successful
      expect(response.status).to eq(400)
    end
    it 'returns error if the query is not there' do
      get '/api/v1/items/find_all'

      items = JSON.parse(response.body, symbolize_names: true)
      expect(items[:message]).to eq("your query could not be completed")
      expect(items[:error]).to eq("name query is either missing or blank")

      expect(response).to_not be_successful
      expect(response.status).to eq(400)
    end
  end
end
