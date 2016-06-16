class SearchsController < AppController
  def index
  	if params[:valor]
	  	valor = params[:valor].downcase.split.last
	  	concept = Concept.where(val:valor).last
			if concept
				@sugestoes = []
				parent_concepts = ConceptQuestion.where(parent_concept:concept)
				parent_concepts.each do |parent_concept|
					question = parent_concept.question
					prox_concept = parent_concept.concept.val
					title_split= question.title.downcase.split
					index = title_split.index(prox_concept) - 1
					st = prox_concept
					while title_split[index] != concept.val
						begin
							st = title_split[index] + " #{st}"
							index = index - 1
						rescue
						end
					end
					@sugestoes << st
					st = ""
				end
				@questions = ConceptQuestion.where(concept:concept).map(&:question)
				render json: {sugestoes: @sugestoes.uniq, questions: @questions}
			end
		end
  end

end
