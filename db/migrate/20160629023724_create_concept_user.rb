class CreateConceptUser < ActiveRecord::Migration
  def change
    create_table :concept_users do |t|
    	t.references :user, index: true, foreign_key: true
    	t.references :concept, index: true, foreign_key: true
    end
  end
end
