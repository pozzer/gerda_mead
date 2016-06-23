class Api::SearchsController < Api::ApiController

  api :GET, '/create', 'POST para criação de recurso'
  desc <<-EOS
  * Verifica se existe um object_ref_id relacionado com o resource_type, filtrando pelo resource_class_name e pela conta
  * Se existir, retorna um erro
  * Se não encontrar o resource class, retorna um erro
  * Se não encontrar o resource type, retorna um erro
  * Se não existir, cria a referência e agenda os jobs para os demais sistemas
====Exemplo de POST
=====JSON para o post
  {
    "create": {
      "resource_class_name": "Usuario",
      "object_ref_id": 2,
      "object_attributes": {
        "id": 2,
        "nome": "Novo Usuário"
      }
    }
  }
====Requisição
Exemplo de Requisição utilizando o comando curl
  'curl -H "Authorization: Token token=_a_Iz17Q4Itk2CHZRCTRtw" -H "Content-type: application/json" -X POST -d '{"create":{"resource_class_name":"Usuario","object_ref_id":2,"object_attributes":{"id":2,"nome":"Novo Usuário"}}}' http://localhost:3000/api/create'
====Retorno com Sucesso:
=====Cabeçalho
    HTTP/1.1 201 OK
    Content-Type: application/json; charset=utf-8
    Date: Wed, 26 Jan 2011 12:56:01 GMT
=====Retorno
    {"resource_object_id": "new_id"}
====Resposta com Erro:
=====Cabeçalho
      HTTP/1.1 422 Unprocessable Entity
      Date: Mon, 17 Jan 2011 19:54:21 GMT
      Content-Type: application/json; charset=utf-8
=====Retorno
      {"error": "Object already exists"}
=====Cabeçalho
      HTTP/1.1 422 Unprocessable Entity
      Date: Mon, 17 Jan 2011 19:54:21 GMT
      Content-Type: application/json; charset=utf-8
=====Retorno
      {"error": "Resource Class not found"}
=====Cabeçalho
      HTTP/1.1 422 Unprocessable Entity
      Date: Mon, 17 Jan 2011 19:54:21 GMT
      Content-Type: application/json; charset=utf-8
=====Retorno
      {"error": "Resource Type not found"}
  EOS
  def questions
    retorno = {}
    if params[:valor]
      valor = params[:valor].downcase.split.last
      retorno = Search.new.question(valor)
    end
    render json: retorno, status: 201
  end

  api :GET, '/update', 'PUT para atualização de recurso'
  desc <<-EOS
  * Verifica se existe um object_ref_id relacionado com o resource_type, filtrando pelo resource_class_name e pela conta
  * Se não existir, retorna um erro
  * Se não encontrar o resource class, retorna um erro
  * Se não encontrar o resource type, retorna um erro
  * Se existir, agenda os jobs para os demais sistemas fazerem a atualização
====Exemplo de POST
=====JSON para o post
  {
    "update": {
      "resource_class_name": "Usuario",
      "object_ref_id": 2,
      "object_attributes": {
        "id": 2,
        "nome": "Novo Usuário"
      }
    }
  }
====Requisição
Exemplo de Requisição utilizando o comando curl
  'curl -H "Authorization: Token token=_a_Iz17Q4Itk2CHZRCTRtw" -H "Content-type: application/json" -X POST -d '{"create":{"resource_class_name":"Usuario","object_ref_id":2,"object_attributes":{"id":2,"nome":"Novo Usuário"}}}' http://localhost:3000/api/update'
====Retorno com Sucesso:
=====Cabeçalho
    HTTP/1.1 201 OK
    Content-Type: application/json; charset=utf-8
    Date: Wed, 26 Jan 2011 12:56:01 GMT
=====Retorno
    "OK"
====Resposta com Erro:
=====Cabeçalho
      HTTP/1.1 422 Unprocessable Entity
      Date: Mon, 17 Jan 2011 19:54:21 GMT
      Content-Type: application/json; charset=utf-8
=====Retorno
      {"error": "Object not exists"}
=====Cabeçalho
      HTTP/1.1 422 Unprocessable Entity
      Date: Mon, 17 Jan 2011 19:54:21 GMT
      Content-Type: application/json; charset=utf-8
=====Retorno
      {"error": "Resource Class not found"}
=====Cabeçalho
      HTTP/1.1 422 Unprocessable Entity
      Date: Mon, 17 Jan 2011 19:54:21 GMT
      Content-Type: application/json; charset=utf-8
=====Retorno
      {"error": "Resource Type not found"}
  EOS
  def update
    update_perform_sync

    Log.put_received_success(@current_system.account.id, @current_system.id,
      "Scheduled jobs for update. Resource Object id #{@resource_object.id}", @resource_object.resource.id, receive_params[:object_attributes])

    render json: {"success" => "OK"}, status: 201
  end

  private
    def receive_params
      action = params[:action].to_sym

      params.require(action).permit(:resource_class_name, :object_ref_id).tap do |whitelisted|
        whitelisted[:object_attributes] = params[action][:object_attributes] if params[action].present?
      end
    end

    def create_perform_sync(resource)
      find_other_systems.each { |system| SyncCreateJob.perform_later(system.id, resource.id, receive_params[:object_attributes]) }
    end

    def update_perform_sync
      find_other_systems.each do |system|
        res_object = @resource_object.resource.resource_objects.where(system_id: system.id).first
        SyncUpdateJob.perform_later(system.id, @resource_object.resource.id, res_object.id, receive_params[:object_attributes])
      end
    end
end
