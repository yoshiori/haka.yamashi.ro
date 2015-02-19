class CreateIncenses < ActiveRecord::Migration
  def change
    create_table :incenses do |t|
      t.references :user, index: true

      t.timestamps null: false
    end
    add_foreign_key :incenses, :users
  end
end
