class AddSecretTokenToAuthentications < ActiveRecord::Migration
  def self.up
    add_column :authentications, :secret, :string
    add_column :authentications, :token, :string
  end

  def self.down
    remove_column :authentications, :token
    remove_column :authentications, :secret
  end
end
