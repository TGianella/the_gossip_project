class RemakeLikesWithPolymorphicAssociation < ActiveRecord::Migration[7.0]
  def change
    remove_reference :likes, :gossip, index: true
    remove_reference :likes, :comment, index: true
    add_reference :likes, :likeable, polymorphic: true, index: true
  end
end
