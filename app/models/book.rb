class Book < ActiveRecord::Base
	has_many :sections, :through => :book_requirements
	has_many :book_requirements

	has_many :textbook_transactions, :dependent => :destroy
	has_many :active_listings, -> { where updated_at: (Time.now - TextbookTransaction.duration)..Time.now, buyer_id: nil }, :class_name => TextbookTransaction

	has_and_belongs_to_many :users

  def self.no_image_link
    "/assets/icons/no_book.png"
  end


	def bookstore_prices
		prices = []
		prices << {
			:condition => 'New',
			:price => bookstore_new_price
		} if bookstore_new_price
		prices << {
			:condition => 'Used',
			:price => bookstore_used_price
		} if bookstore_used_price
		prices
	end

	def amazon_merchant_prices
		prices = []
		prices << {
			:condition => 'New',
			:price => amazon_merchant_new_price
		} if amazon_merchant_new_price
		prices << {
			:condition => 'Used',
			:price => amazon_merchant_used_price
		} if amazon_merchant_used_price
		prices
	end

	def amazon_official_prices
		prices = []
		prices << {
			:condition => 'New',
			:price => amazon_official_new_price
		} if amazon_official_new_price
		prices << {
			:condition => 'Used',
			:price => amazon_official_used_price
		} if amazon_official_used_price
		prices
	end
end