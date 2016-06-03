class ConceptQuestion < ActiveRecord::Base
	##########GERDA########
	belongs_to :question
	belongs_to :concept
	belongs_to :parent_concept, class_name: "Concept"

	def init(val)
		Concept.where(val:val)
	end

end