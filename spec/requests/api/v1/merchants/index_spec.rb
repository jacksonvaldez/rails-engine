require 'rails_helper'

RSpec.describe 'Get All Merchants' do

  before(:each) do
    5.times do
      Merchant.create!(name: Faker::Name.name)
    end
  end

  it 'returns merchants' do
    get '/api/v1/merchants'

    expect(response).to be_successful

    merchants = JSON.parse(response.body, symbolize_names: true)

    expect(merchants[:data].length).to eq(5)

    expect(merchants[:data].first[:id]).to be_a(Integer)
    expect(merchants[:data].first[:type]).to be_a(String)
    expect(merchants[:data].first[:type]).to eq('merchant')

    expect(merchants[:data].first[:attributes][:name]).to be_a(String)
  end

end
