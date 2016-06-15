class SearchsController < AppController
  def index
		binding.pry
		Question.all
  end

end
