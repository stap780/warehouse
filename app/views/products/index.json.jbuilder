json.array!(@products) do |product|
  json.extract! product, :id, :inid, :sku, :title, :qt, :cost_price, :price
  json.url product_url(product, format: :json)
end
