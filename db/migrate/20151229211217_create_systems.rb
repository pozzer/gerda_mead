class CreateSystems < ActiveRecord::Migration
  def change
    create_table :systems do |t|
      t.string :description
      t.string :api_url
      t.string :token
      t.references :account

      t.timestamps null: false
    end
  end
end
