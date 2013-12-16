class NormalizeProducts < ActiveRecord::Migration
  def up
  	add_column :sales, :product_id, :integer
  	populate_sales
  	remove_column :sales, :product_name
  end

  def down
  	add_column :sales, :product_name, :string
  	unpopulate_sales
  	remove_column :sales, :product_id
  	Product.delete_all
  end

  def populate_sales
  	Sale.reset_column_information
  	Sale.all.each do |s|
  		s.product = Product.find_or_create_by(name: s.product_name)
  		s.save
  	end
  end

  def unpopulate_sales
  	Sale.find_each do |s|
  		s.product_name = s.product_name
  		s.save
  	end
  end
end
