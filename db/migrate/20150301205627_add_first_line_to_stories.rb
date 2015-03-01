class AddFirstLineToStories < ActiveRecord::Migration
  def change
    add_column :stories, :first_line, :text
  end
end
