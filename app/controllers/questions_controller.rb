class QuestionsController < AppController
  def index
		@questions = Question.all
    respond_with(@questions)
  end

  def show
  	@question = Question.find(params[:id])
  	respond_with(@questions)
  end
end
