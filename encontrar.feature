Feature: Encontrar um usuário
    Como uma pessoa qualquer
    Desejo consultar os dados de um usuário
    Para visualizar as informações deste usuário

    Background: Informações importantes
        Given url baseUrl
        And path "users"

        Scenario: Retorna um usuário
            * def registrar = call read("hook.feature@post")
            And path registrar.response.id
            When method get
            Then status 200
            And match response contains {id: "#(registrar.response.id)", name: "#(registrar.response.name)", email: "#(registrar.response.email)", createdAt: "#string", updatedAt: "#string"}
            * def userId = registrar.response.id
            * def deletar = call read("hook.feature@delete")
        #O usuário foi localizado através de seu id. (Critérios de aceite 1)
        
        Scenario: Não localizar o usuário pelo id
            And path java.util.UUID.randomUUID()
            Then method get
            Then status 404
        #O usuário não vai ser localizado pelo id, porque esse id não foi cadastrado, assim eu obtenho o response code 404. (Critério de aceite 2)
        