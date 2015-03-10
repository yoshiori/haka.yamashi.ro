class AddSourceToIncenses < ActiveRecord::Migration
  def change
    add_column :incenses, :source, :string
  end
end
