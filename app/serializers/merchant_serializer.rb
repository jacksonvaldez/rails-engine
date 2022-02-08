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

end
