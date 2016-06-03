class CreateTableConcept < ActiveRecord::Migration
  def change
    create_table :concepts do |t|
    	t.string :val, index: true
    end
  end
end
