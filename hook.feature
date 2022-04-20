@ignore
Feature: Hooks

    @post
    Scenario: Registra um novo usuário
        * def payload = { name: "Vitor Galinari", email: "vitor@galinari.com"}
        Given url baseUrl
        And path "users"
        And request payload
        When method post
        Then status 201
    
    @delete
    Scenario: Remover um usuário
        Given url baseUrl
        And path "users"
        And path userId
        When method delete

    @postAleatorio    
    Scenario: Registra um novo usuário
        * def emon = "Vitor" + java.util.UUID.randomUUID()
        * def liame = java.util.UUID.randomUUID() + "@galinari.com"
        Given url baseUrl
        And path "users"
        And request {name: "#(emon)", email: "#(liame)"}
        When method post
        Then status 201
    