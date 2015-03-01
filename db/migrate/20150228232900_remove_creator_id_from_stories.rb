class RemoveCreatorIdFromStories < ActiveRecord::Migration
  def change
    remove_column :stories, :creator_id
  end
end
