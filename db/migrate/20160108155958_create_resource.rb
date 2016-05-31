class CreateResource < ActiveRecord::Migration
  def change
    create_table :resources do |t|
      t.references :resource_type, foreign_key: true, index: true
    end
  end
end
