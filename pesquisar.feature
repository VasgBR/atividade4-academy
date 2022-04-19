Feature: Pesquisar usuário
    Como uma pessoa qualquer
    Desejo pesquisar usuário por nome ou e-mail
    Para ser capaz de encontrar um usuário cadastrado facilmente

    Background: Informações importantes
        Given url baseUrl
        And path "search"

    Scenario: Procurar por um usuário pelo nome
        * def registrar = call read("hook.feature@post")
        And param value = "Vitor Galinari"
        #Critério de aceite 1
        When method get
        Then status 200
        And match response == "#array"
        And match response contains {id: "#string", name: "#string", email: "#string", createdAt: "#string", updatedAt: "#string"}
        And match response contains {id: "#(registrar.response.id)", name: "#(registrar.response.name)", email: "#(registrar.response.email)", createdAt: "#string", updatedAt: "#string"}
        #Critério de aceite 2
        * def userId = registrar.response.id
        * def deletar = call read("hook.feature@delete")
    
    Scenario: Procurar por um usuário pelo email
        * def registrar = call read("hook.feature@post")
        And param value = "vitor@galinari.com"
        #Critério de aceite 1
        When method get
        Then status 200
        And match response == "#array"
        And match response contains {id: "#string", name: "#string", email: "#string", createdAt: "#string", updatedAt: "#string"}
        And match response contains {id: "#(registrar.response.id)", name: "#(registrar.response.name)", email: "#(registrar.response.email)", createdAt: "#string", updatedAt: "#string"}
        #Critério de aceite 2
        * def userId = registrar.response.id
        * def deletar = call read("hook.feature@delete")
        