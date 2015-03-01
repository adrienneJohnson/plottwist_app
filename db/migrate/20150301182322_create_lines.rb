class CreateLines < ActiveRecord::Migration
  def change
    create_table :lines do |t|
      t.text :body
      t.integer :story_id
      t.integer :user_id

      t.timestamps null: false
    end
  end
end
