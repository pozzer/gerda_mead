class CreateConceptQuestion < ActiveRecord::Migration
  def change
    create_table :concept_questions do |t|
    	t.references :question, index: true, foreign_key: true
    	t.references :concept, index: true, foreign_key: true
    	t.integer :parent_concept_id, index: true, foreign_key: true
    end
  end
end
