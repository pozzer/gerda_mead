class ConceptsController < AppController
  def index
		@concepts = Concept.all
    respond_with(@concepts)
  end


end
