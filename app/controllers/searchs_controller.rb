class SearchsController < AppController
  def index
  	if params[:valor]
			valor = params[:valor].downcase.split.last
  		retorno = Search.new.question(valor)
			render json: retorno
		end
  end

end
