class CreateTokens < ActiveRecord::Migration
  def change
    create_table :tokens do |t|
      t.references :user, index: true
      t.datetime :deleted_at
      t.string :token

      t.timestamps null: false
    end
    add_foreign_key :tokens, :users
    add_index :tokens, :token, unique: true
  end
end
