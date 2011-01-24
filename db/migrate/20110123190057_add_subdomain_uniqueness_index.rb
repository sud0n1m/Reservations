class AddSubdomainUniquenessIndex < ActiveRecord::Migration
  def self.up
    add_index :properties, :subdomain, :unique => true
  end

  def self.down
    remove_index :properties, :subdomain
  end
end
