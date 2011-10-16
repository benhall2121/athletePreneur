class AddUserTypeApplyToUsers < ActiveRecord::Migration
  def self.up
    add_column :users, :user_type_apply, :string
  end

  def self.down
    remove_column :users, :user_type_apply
  end
end
