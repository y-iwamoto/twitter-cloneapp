class AddDetailsToUsers < ActiveRecord::Migration
  def change
    add_column :users, :name, :string
    add_column :users, :telephone, :string
    add_column :users, :self_introduction, :text
    add_column :users, :place, :string
    add_column :users, :homepage_url, :string
    add_column :users, :birthday, :date
  end
end
