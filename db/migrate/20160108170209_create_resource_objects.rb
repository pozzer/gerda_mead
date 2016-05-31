class CreateResourceObjects < ActiveRecord::Migration
  def change
    create_table :resource_objects do |t|
      t.references :resource, index: true, foreign_key: true, null: false
      t.integer :object_ref, null: false
      t.references :system, index: true, foreign_key: true, null: false

      t.timestamps null: false
    end

    add_index :resource_objects, [:resource_id, :object_ref, :system_id], name: "resource_objects_unique_idx", unique: true
  end
end
