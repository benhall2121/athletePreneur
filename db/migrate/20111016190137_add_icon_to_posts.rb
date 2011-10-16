class AddIconToPosts < ActiveRecord::Migration
  def self.up
    add_column :posts, :icon, :string
  end

  def self.down
    remove_column :posts, :icon
  end
end
