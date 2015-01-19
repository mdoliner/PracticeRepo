class CreateContactGroups < ActiveRecord::Migration
  def change
    create_table :contact_groups do |t|
      t.integer :user_id, presence: true
      t.integer :contact_grouping_id, presence: true

      t.timestamps
    end
    add_index :contact_groups, :user_id
    add_index :contact_groups, :contact_grouping_id
  end
end
