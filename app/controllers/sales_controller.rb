class SalesController < ApplicationController

	def index
		@closed_sales = Sale.closed_sales_three_months
		@sales = Sale.all
	end

	def show
		@sale = Sale.find(params(:id))
	end

end