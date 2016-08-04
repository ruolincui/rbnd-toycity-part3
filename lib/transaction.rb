class Transaction
	attr_reader :id, :customer, :type

	attr_accessor :product

	@@transactions = []

	def initialize(customer, product, type = "purchase")
		@id = @@transactions.length + 1
		@customer = customer
		@product = product
		@type = type
		add_to_transactions
	end

	def self.all
		@@transactions
	end


	private

	def add_to_transactions
		if id_exists?
			raise DuplicateTransactionError, "DuplicateTransactionError: '#{id}' already exists."
		end
		@@transactions << self
		if @type == "purchase"
			@product.stock -= 1
		else
			@product.stock += 1
		end
	end


	def id_exists?
		if Transaction.find(id) != []
			return true
		else
			return false
		end
	end

	def self.find(id)
		@@transactions.each do |transaction|
			if id == transaction.id
				return transaction
			end
		end
		return []
	end

	def self.find_by_customer(customer)
		transactions_by_customer = []
		@@transactions.each do |transaction|
			if customer == transaction.customer
				transactions_by_customer << transaction 
			end
		end
		return transactions_by_customer
	end


end






