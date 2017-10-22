class CreateNotifications < ActiveRecord::Migration
  def change
    create_table :notifications do |t|
      t.boolean :read, default: false
      t.references :user, index: true
      t.references :tweet, index: true

      t.timestamps
    end
  end
end
