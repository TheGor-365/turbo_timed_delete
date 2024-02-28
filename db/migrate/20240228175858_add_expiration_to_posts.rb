class AddExpirationToPosts < ActiveRecord::Migration[7.0]
  def change
    add_column :posts, :expires_at, :datetime
    add_column :posts, :deleted, :boolean, default: false
  end
end
