class CreateHomeworks < ActiveRecord::Migration[7.1]
  def change
    create_table :homeworks do |t|
      t.references :teacher, null: false, foreign_key: { to_table: :users }
      t.string :title, null: false
      t.datetime :due_at, null: false
      t.string :resource_file_id

      t.timestamps
    end
  end
end
