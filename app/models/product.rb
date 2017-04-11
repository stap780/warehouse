class Product < ActiveRecord::Base
  require 'open-uri'
  require 'nokogiri'
  require 'rest-client'
  has_many :variants, :dependent => :destroy
  accepts_nested_attributes_for :variants, allow_destroy: true #,reject_if: proc { |attributes| attributes['weight'].blank? }
  validates :inid, uniqueness: true

	
  def self.downloadproduct #загружаем или добавляем товары 
     myprpage = 0
     while myprpage < 1
       myprpage = myprpage + 1
          
     uri = "http://ee8d04c00d924c5545c8f33893afd645:0957c04ecd191ef45fe07762af6dcc68@myshop-327-26.myinsales.ru/admin/products.xml?&limit=150=&page=#{(myprpage)}"
     response = RestClient.get uri, :accept => :xml, :content_type => "application/xml"
     data = Nokogiri::XML(response)
     product = "products/product"
     mypr = data.xpath(product)
     
			mypr.each do |pr|
				inid = pr.xpath("id").text
				sku = pr.xpath("variants/variant/sku").first.text
				title = pr.xpath("title").text
				
				@product = Product.where("inid = ?", pr.xpath("id").text)
				if @product.present?
				@product.each do |p|
				p.update_attributes(:title => title)
				end
				else
				@product.create( :inid => inid, :sku => sku, :title => title)
				end
			end
		
		end
	 end   
  def self.updateproduct #обновляем товары и варианты из магазина 
	  @products = Product.order(:id)
	  @products.each do |pr|
		uri = "http://ee8d04c00d924c5545c8f33893afd645:0957c04ecd191ef45fe07762af6dcc68@myshop-327-26.myinsales.ru/admin/products/#{pr.inid}.xml"
		response = RestClient.get uri, :accept => :xml, :content_type => "application/xml"
		if response.code == 200
			data = Nokogiri::XML(response)
			var = data.xpath("//variants/variant")
			
				var.each do |var|
				variant_inid = var.xpath("id").text
				opt_title = var.xpath("title").text
				sku = var.xpath("sku").text
				price = var.xpath("price").text
				quantity = var.xpath("quantity").text
				weight = var.xpath("weight").text
				
				@variant = Variant.find_by_variant_inid("#{(variant_inid)}")
					if @variant.present?
					@variant.update_attributes( :sku => sku, :price => price, :quantity => quantity, :weight => weight, :opt_title => opt_title)
					
					else
					@variant = Variant.new(:product_id =>pr.id,:variant_inid => variant_inid, :sku => sku, :price => price, :quantity => quantity, :weight => weight, :opt_title => opt_title)
					@variant.save
					end
				end
			end
 		
			if response.code == 404
			pr.delete
 			end
 			if response.code == 503
	 			puts "sleep now"
	 		sleep(1.minutes)
	 		end	
	end
  end
  		
			  		
	
end
