Feature: Atualizar um usuário
    Como uma pessoa qualquer
    Desejo atualizar as informações de determinado usuário
    Para ter o registro de suas informações atualizadas

    Background: Informações importantes
        Given url baseUrl
        And path "users"

        Scenario: Atualizar informações de um usuário
        * def registrar = call read("hook.feature@post")
            And path registrar.response.id
        #Usuário identificado pelo id. (Critério de aceite 1)
            And request { name: "VitorGalinari", email: "vitor14@galinari.com"}
        #Com o request eu coloco as informações necessárias para atualizar um usuário, que no caso são: nome e email. (Critério de aceite 3)
            When method put
            Then status 200
            And match response contains {id: "#(response.id)", name: "#(response.name)", email: "#(response.email)", createdAt: "#string", updatedAt: "#string"}
            * def userId = response.id
            * def deletar = call read("hook.feature@delete")

        Scenario: Atualizar usuário com email inválido
        * def registrar = call read("hook.feature@postAleatorio")
            And path registrar.response.id
            And request { name: "Vitor Galinari", email: "vitorgalinari.com"}
            When method put
            Then status 400
        #O email informado possuindo o formato inválido deve fazer com que a operação seja cancelada, me retornando um response code 400. (Critério de aceite 4)

        Scenario: Atualizar um usuário com mais de 100 caracteres no nome
        * def registrar = call read("hook.feature@postAleatorio")
            And path registrar.response.id
            And request { name: "VitorVitorVitorVitorVitorVitorVitorVitorVitorVitorVitorVitorVitorVitorVitorVitorVitorVitorVitorVitorV", email: "vitor@galinari.com"}
            When method put
            Then status 400
        #Não deve ser possível atualizar um usuário com um nome com mais de 100 caracteres, me retornando um response code 400. (Critério de aceite 7)

        Scenario: Atualizar um usuário com mais de 60 caracteres no email
        * def registrar = call read("hook.feature@postAleatorio")
            And path registrar.response.id
            And request { name: "Vitor Galinari", email: "vitorvitorvitorvitorvitor@galinarigalinarigalinarigalinar.com"}
            When method put
            Then status 400
        #Não deve ser possível atualizar um usuário com um email com mais de 60 caracteres, me retornando um response code 400. (Critério de aceite 8)

        Scenario: Não localizar o usuário pelo id
        * def registrar = call read("hook.feature@postAleatorio")
            And path java.util.UUID.randomUUID()
            And request { name: "Vitor Galinari", email: "vitor@galinari.com"}
            Then method put
            Then status 404
        #O usuário não vai ser localizado pelo id, porque ele foi excluido, assim eu obtenho o response code 404. (Critério de aceite 2)
        