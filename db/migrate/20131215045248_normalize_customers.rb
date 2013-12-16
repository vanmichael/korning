class NormalizeCustomers < ActiveRecord::Migration
  def up
  	add_column :sales, :customer_id, :integer
  	populate_customers
  	remove_column :sales, :customer_and_account_no
  end

  def down
  	add_column :sales, :customer_and_account_no, :string
  	unpopulate_customers
  	Customer.delete_all
  end

  def populate_customers
  	Sale.reset_column_information
  	Sale.find_each do |s|
  		customer = get_customer(s.customer_and_account_no)
  		cust = Customer.find_or_create_by(name: @name, account_number: @account_number)
  		s.customer_id = cust.id
  		s.save
  	end
  end

  def unpopulate_customers
  	Sale.find_each do |s|
  		s.customer_and_account_no = "#{s.customer.name} (#{s.customer.account_number}"
  		s.save
  	end
  end

  def get_customer(customer)
  	format_customer = customer.gsub(/[(]/,"")
  	array = format_customer.split(" ")
  	@name = array[0]
  	@account_number = array[1]
  end

end
