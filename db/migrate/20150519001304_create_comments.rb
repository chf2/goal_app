class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.integer :commentable_id
      t.string :commentable_type
      t.integer :author_id
      t.text :body

      t.timestamps
    end

    add_index :comments, [:commentable_id, :commentable_type]
    add_index :comments, :author_id
  end
end
