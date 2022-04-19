Feature: Listar usuários
    Como uma pessoa qualquer
    Desejo consultar todos os usuários cadastrados
    Para ter as informações de todos os usuários

    Scenario: Listar todos os usuários cadastrados
        * def registrar = call read("hook.feature@post")
        Given url baseUrl
        And path "users"
        When method get
        Then status 200
        And match response == "#array"
        And match response contains {id: "#string", name: "#string", email: "#string", createdAt: "#string", updatedAt: "#string"}
        And match response contains {id: "#(registrar.response.id)", name: "#(registrar.response.name)", email: "#(registrar.response.email)", createdAt: "#string", updatedAt: "#string"}
        * def userId = registrar.response.id
        * def deletar = call read("hook.feature@delete")
    #Com o match response contains eu consigo testar se todas as informações de usuários cadastrados são fornecidas após a consulta (Critério de aceite 1)
