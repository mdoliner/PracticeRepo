class RemoveUniqueFromSubmitterId < ActiveRecord::Migration
  def change
    remove_index :shortened_urls, :submitter_id
    add_index :shortened_urls, :submitter_id
  end
end
