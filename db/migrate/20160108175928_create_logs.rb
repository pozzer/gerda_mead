class CreateLogs < ActiveRecord::Migration
  def change
    create_table :logs do |t|
      t.references :account, index: true, foreign_key: true
      t.references :system, index: true, foreign_key: true
      t.references :resource, index: true, foreign_key: true
      t.integer :status
      t.integer :log_type
      t.text :message

      t.timestamps null: false
    end
  end
end
