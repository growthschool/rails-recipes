class CreateProfiles < ActiveRecord::Migration[5.0]
  def change
    create_table :profiles do |t|

      t.timestamps
    end
  end
end
