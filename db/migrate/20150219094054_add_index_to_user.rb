class AddIndexToUser < ActiveRecord::Migration
  def change
    add_index :incenses, :created_at
    add_index :incenses, [:user_id, :created_at]
  end
end
