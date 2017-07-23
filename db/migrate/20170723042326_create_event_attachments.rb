class CreateEventAttachments < ActiveRecord::Migration[5.0]
  def change
    create_table :event_attachments do |t|
      t.integer :event_id, :index => true
      t.string :attachment
      t.string :description
      t.timestamps
    end
  end
end
