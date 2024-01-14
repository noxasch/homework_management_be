class CreateStudentHomeworks < ActiveRecord::Migration[7.1]
  disable_ddl_transaction!
  
  def change
    create_table :student_homeworks do |t|
      t.references :student, null: false, foreign_key: { to_table: :users }
      t.references :homework, null: false, foreign_key: true
      t.integer :status, default: 0
      t.string :submitted_file_id
      t.datetime :invited_at

      t.timestamps
    end

    commit_db_transaction

    add_index :student_homeworks, [:homework_id, :student_id], unique: true
  end
end
