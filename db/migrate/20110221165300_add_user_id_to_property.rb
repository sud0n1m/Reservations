class AddUserIdToProperty < ActiveRecord::Migration
  def self.up
    add_column :properties, :user_id, :integer
    add_index :properties, :user_id
  end

  def self.down
    remove_column :properties, :user_id
  end
end
