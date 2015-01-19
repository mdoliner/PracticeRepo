class CreateContactGroupings < ActiveRecord::Migration
  def change
    create_table :contact_groupings do |t|
      t.integer :contact_group_id, presence: true
      t.integer :contact_id, prsenece: true

      t.timestamps
    end

    remove_column :contact_groups, :contact_grouping_id
    add_index :contact_groupings, :contact_group_id
    add_index :contact_groupings, :contact_id
  end
end
