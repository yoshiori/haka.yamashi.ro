class DeleteNotNullToUsersName < ActiveRecord::Migration
  def change
    change_column_null :users, :name, true
  end
end
