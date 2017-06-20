class AddFriendlyIdToEvents < ActiveRecord::Migration[5.0]
  def change
    add_column :events, :friendly_id, :string
    add_index :events, :friendly_id, :unique => true

    Event.find_each do |e|
      e.update( :friendly_id => SecureRandom.uuid )
    end
  end
end
