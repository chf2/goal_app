class AddCheersToUsers < ActiveRecord::Migration
  def change
    add_column :users, :cheers, :integer

    create_table :cheers do |t|
      t.integer :user_id, null: false
      t.integer :goal_id, null: false

      t.timestamps
    end

    add_index :cheers, :user_id
    add_index :cheers, :goal_id
  end
end
