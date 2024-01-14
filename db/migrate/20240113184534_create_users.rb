class CreateUsers < ActiveRecord::Migration[7.1]
  def change
    create_table :users do |t|
      t.string :role, null: false, default: 'student'
      t.string :name, null: false
      t.string :email, null: false, index: { unique: true }
      t.string :password_digest
      t.integer :status, null: false, default: 0

      t.timestamps
    end
  end
end
