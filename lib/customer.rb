class Customer
	attr_reader :name

	@@customers = []

	def initialize(options={})
		@name = options[:name]
		add_to_customers
	end

	def self.all
		@@customers
	end

	def purchase(product)
		if product.stock == 0
			raise OutOfStockError, "OutOfStockError: '#{product.title}' is out of stock."
		end
		Transaction.new(self, product)
	end

	def item_return(product)
		Transaction.new(self, product, "return")	
	end



	private
	def add_to_customers
		if name_exists?
			raise DuplicateCustomerError, "DuplicateCustomerError: '#{name}' already exists."
		else
			@@customers << self
		end
	end

	def name_exists?
		if Customer.find_by_name(name) != []
			return true
		else
			return false
		end
	end

	def self.find_by_name(name)
		@@customers.each do |customer|
			if name == customer.name
				return customer
			end
		end
		return []
	end

end

