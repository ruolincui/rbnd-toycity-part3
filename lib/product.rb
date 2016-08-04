class Product
	attr_reader :title, :price

	attr_accessor :stock

	@@products = []

	def initialize(options={})
		@title = options[:title]
		@price = options[:price]
		@stock = options[:stock]
		add_to_products
	end

	def self.all
		@@products
	end

	def self.stock
		@stock
	end

	def in_stock?
		if @stock == 0
			return false
		else
			return true
		end
	end

	def self.in_stock
		products_in_stock = []
		@@products.each do |product|
			if product.in_stock?
				products_in_stock.push(product)
			end
		end
		return products_in_stock
	end
		

	private

	def add_to_products
		if title_exists?
			raise DuplicateProductError, "DuplicateProductError: '#{title}' already exists."
		else
			@@products << self
		end
	end

	def title_exists?
		if Product.find_by_title(title) != []
			return true
		else
			return false
		end
	end

	def self.find_by_title(title)
		@@products.each do |product|
			if title == product.title
				return product
			end
		end
		return []
	end
	
end
