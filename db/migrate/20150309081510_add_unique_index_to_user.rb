class AddUniqueIndexToUser < ActiveRecord::Migration
  def change
    remove_index :users, :nickname
    add_index :users, :nickname, unique: true
  end
end
