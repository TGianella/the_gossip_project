class RemoveReferencesFromComments < ActiveRecord::Migration[7.0]
  def change
    remove_reference :comments, :parent_comment, foreign_key: { to_table: :comments }
    remove_reference :comments, :gossip, index: true
  end
end
