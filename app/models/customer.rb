class Customer < ActiveRecord::Base
	has_many :sales

	def invoice_frequency
		frequency = Hash.new(0)
		self.sales.each do |sale|
			frequency[sale.invoice_frequency] += 1
		end
		"Monthly: #{frequency["Monthly"]}\n
		Quarterly: #{frequency["Quarterly"]}\n
		Once: #{frequency["Once"]}"
	end

	def website
		if self.name == "Motorola"
			"www.motorola.com"
		elsif self.name == "LG"
			"www.lg.com"
		elsif self.name == "HTC"
			"www.htc.com"
		elsif self.name == "Nokia"
			"www.nokia.com"
		elsif self.name == "Samsung"
			"www.samsung.com"
		elsif self.name == "Apple"
			"www.apple.com"
		end
	end
end
