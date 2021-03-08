class AddRowOrderToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :row_order, :integer

    User.find_each do |u|
      u.update( :row_order => :last )
    end

    add_index :users, :row_order
  end
end
