class RemoveWebsiteFromCustomers < ActiveRecord::Migration
  def change
  	remove_column :customers, :website
  end
end
