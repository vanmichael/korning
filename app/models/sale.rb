class Sale < ActiveRecord::Base
	belongs_to :product
	belongs_to :employee
	belongs_to :customer


	#called in the view
	def price_per_unit
		"$ #{(self.sale_amount/self.units_sold).round(2)}"
	end

	#called in the controller

	def self.closed_sales_three_months
		fake_today = DateTime.new(2012,DateTime.now.month,DateTime.now.day)
		self.where(sale_date: (fake_today - 90.day)..(fake_today)).order(sale_date: :desc)
	end
end
