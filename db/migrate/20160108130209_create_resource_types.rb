class CreateResourceTypes < ActiveRecord::Migration
  def change
    create_table :resource_types do |t|
      t.references :resource_class, index: true, foreign_key: true
      t.string :url
      t.references :account, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
