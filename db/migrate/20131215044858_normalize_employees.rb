class NormalizeEmployees < ActiveRecord::Migration
  def up
  	add_column :sales, :employee_id, :integer
  	populate_employees
  	remove_column :sales, :employee
  end

  def down
  	add_column :sales, :employee, :string
  	unpopulate_employees
  	Employee.delete_all
  end

  def populate_employees
  	Sale.reset_column_information
  	Sale.find_each do |s|
  		get_employee_info(s.employee)
  		employee = Employee.find_or_create_by(name: "#{@first_name} #{@last_name}" , email: "#{@email}")
  		s.employee_id = employee.id
  		s.save
  	end
  end

  def unpopulate_employees
  	Sale.find_each do |s|
  		s.employee = "#{s.employee.name} #{s.employee.email}"
  		s.save
  	end
  end

  def get_employee_info(employee)
  	format_employee = employee.gsub(/[()]/,"")
  	array = format_employee.split(' ')
  	@first_name = array[0]
  	@last_name = array[1]
  	@email = array[2]
  end
end
