module Authentication
  extend ActiveSupport::Concern
  extend Apipie::DSL::Concern

  private
    api :GET, '/', 'Endpoint de autenticação'
    desc <<-EOS
  * Faz a autenticação por token
  * Verifica se o token da requisição é de algum sistema
====Requisição
Exemplo de chamada API autenticada (onde _a_Iz17Q4Itk2CHZRCTRtw é o authentication_token do sistema):
Exemplo de Requisição utilizando o comando curl
  'curl -H "Authorization: Token token=_a_Iz17Q4Itk2CHZRCTRtw" -H "Content-type: application/json" http://localhost:3000/api/some_resource'
====Retorno com Sucesso:
=====Cabeçalho
    HTTP/1.1 200 OK
    Content-Type: application/json; charset=utf-8
    Date: Wed, 26 Jan 2011 12:56:01 GMT
=====Retorno
    json do resource solicitado
====Resposta com Erro:
=====Cabeçalho
      HTTP/1.1 401 Unauthorized
      Date: Mon, 17 Jan 2011 19:54:21 GMT
      Content-Type: application/json; charset=utf-8
=====Retorno
      {"error":"Bad credentials"}
    EOS
    def authenticate
      authenticate_token || render_unauthorized
    end

    def authenticate_token
      authenticate_with_http_token do |token, options|
        token == 'token'
      end
    end

    def render_unauthorized
      render :json => {:error => 'Bad credentials'}, :status => 401
    end
end
