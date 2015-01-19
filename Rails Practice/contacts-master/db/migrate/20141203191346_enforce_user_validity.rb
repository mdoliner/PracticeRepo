class EnforceUserValidity < ActiveRecord::Migration
  def change
    change_column :users, :username, :string, {unique: true, presence: true}
  end
end
