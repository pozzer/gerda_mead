class ConceptQuestionsController < AppController
  def index
		@concept_questions = ConceptQuestion.all
    respond_with(@concept_questions)
  end

  def finder
  end


end
