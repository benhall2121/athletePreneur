class AddScreenNameToAuthentications < ActiveRecord::Migration
  def self.up
    add_column :authentications, :screen_name, :string
  end

  def self.down
    remove_column :authentications, :screen_name
  end
end
