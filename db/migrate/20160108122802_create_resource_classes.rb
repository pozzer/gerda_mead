class CreateResourceClasses < ActiveRecord::Migration
  def change
    create_table :resource_classes do |t|
      t.string :name
      t.references :account, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
