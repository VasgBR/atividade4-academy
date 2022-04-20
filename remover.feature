Feature: Remover um usuário
    Como uma pessoa qualquer
    Desejo remover um usuário
    Para que suas informações não estejam mais registradas

    Background: Informações importantes
        Given url baseUrl
        And path "users"

        Scenario: Remover um usuário
            * def registrar = call read("hook.feature@post")
            And path registrar.response.id
        #Usuário identificado pelo id. (Critério de aceite 1)
            When method delete
            Then status 204

         Scenario: Não localizar o usuário por id
            And path java.util.UUID.randomUUID()
            When method delete
            Then status 204
        #O usuário não vai ser localizado pelo id, porque ele não foi cadastrado, mas mesmo assim eu obtenho o response code 204. (Critério de aceite 2)
