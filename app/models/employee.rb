class Employee < ActiveRecord::Base
	has_many :sales

	def first_name
		name = self.name.split(' ')
		name[0]
	end

	def last_name
		name = self.name.split(' ')
		name[1]
	end
end
