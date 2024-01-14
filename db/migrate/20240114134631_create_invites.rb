class CreateInvites < ActiveRecord::Migration[7.1]
  def change
    create_table :invites do |t|
      t.string :token, null: false, index: { unique: true }
      t.integer :expires_in, null: false
      t.references :student, null: false, foreign_key: { to_table: :users }

      t.timestamps
    end
  end
end
