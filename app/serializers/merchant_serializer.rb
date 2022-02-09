class MerchantSerializer

  def self.merchants_index(merchants)

    data = merchants.map do |merchant|
      {
        id: merchant.id,
        type: 'merchant',
        attributes: {
          name: merchant.name
        }
      }
    end

    {
      data: data
    }
  end

  def self.merchants_show(merchant)
    data = {
      id: merchant.id.to_s,
      type: 'merchant',
      attributes: {
        name: merchant.name
      }
    }

    {
      data: data
    }
  end

  def self.invalid_id
    {
      "message": "invalid merchant id"
    }
  end

end
