class CreateRegistrations < ActiveRecord::Migration[5.0]
  def change
    create_table :registrations do |t|

      t.timestamps
    end
  end
end
