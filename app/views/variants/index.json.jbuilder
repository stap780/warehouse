json.array!(@variants) do |variant|
  json.extract! variant, :id, :variant_inid, :sku, :cost_price, :price, :quantity, :weight, :opt_title, :product_id, :supplier_id
  json.url variant_url(variant, format: :json)
end
