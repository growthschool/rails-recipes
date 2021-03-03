class CreateMemberships < ActiveRecord::Migration[5.0]
  def change
    create_table :memberships do |t|

      t.timestamps
    end
  end
end
