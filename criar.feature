Feature: Criar usuário
    Como uma pessoa qualquer
    Desejo registrar informações de usuário
    Para poder manipular estas informações livremente

    Background: Informações importantes
        * def payload = { name: "Vitor Galinari", email: "vitor@galinari.com"}
        Given url baseUrl
        And path "users"
    #Com o def payload eu coloco as informações necessárias para cadastrar um usuário, que no caso são: nome e email. (Critério de aceite 1)

        Scenario: Registra um novo usuário
            And request payload
            When method post
            Then status 201
            And match response contains {id: "#(response.id)", name: "#(response.name)", email: "#(response.email)", createdAt: "#string", updatedAt: "#string"}
            * def userId = response.id
            * def deletar = call read("hook.feature@delete")

        Scenario: Registrar um novo usuário com email já existente
            * def registrar = call read("hook.feature@post")
            And request payload
            When method post
            Then status 422
            And match response contains { error: "User already exists."}
            * def userId = registrar.response.id
            * def deletar = call read("hook.feature@delete")
        #Na tentativa de criar um usuário com um email que já é utilizado por outro usuário (nesse caso com o mesmo email do usuário do primeiro cenário), deve ter o response code 422. (Critério de aceite 3)
        #Com o match response contains eu consigo testar se no response body aparece a mensagem "User already exists.". (Critério de aceite 4)

        Scenario: Registrar um novo usuário sem o nome
            And request { name: "", email: "vitor@galinari.com"}
            When method post
            Then status 400
        #Como eu não coloquei o nome que é uma das informações necessárias para cadastrar um usuário, eu obtenho o erro 400. (Critério de aceite 1)

        Scenario: Registrar um novo usuário sem o email
            And request { name: "Vitor Galinari", email: ""}
            When method post
            Then status 400
        #Como eu não coloquei o email que é uma das informações necessárias para cadastrar um usuário, eu obtenho o erro 400. (Critério de aceite 1)

        Scenario: Registrar um novo usuário sem o nome e email
            And request { name: "", email: ""}
            When method post
            Then status 400
        #Como eu não coloquei o nome e o email que são as informações necessárias para cadastrar um usuário, eu obtenho o erro 400. (Critério de aceite 1)

        Scenario: Registrar um novo usuário com email sem o @
            And request { name: "Vitor Galinari", email: "vitorgalinari.com"}
            When method post
            Then status 400
        #O email informado possuindo o formato inválido deve fazer com que a operação seja cancelada, me retornando um response code 400. (Critério de aceite 2)

        Scenario: Registrar um novo usuário com email sem o .com
            And request { name: "Vitor Galinari", email: "vitor@galinari"}
            When method post
            Then status 400
        #O email informado possuindo o formato inválido deve fazer com que a operação seja cancelada, me retornando um response code 400. (Critério de aceite 2)

        Scenario: Registrar um usuário com mais de 100 caracteres no nome
            And request { name: "VitorVitorVitorVitorVitorVitorVitorVitorVitorVitorVitorVitorVitorVitorVitorVitorVitorVitorVitorVitorV", email: "vitor14@galinari.com"}
            When method post
            Then status 400
        #Não deve ser possível cadastrar um usuário com um nome com mais de 100 caracteres, me retornando um response code 400. (Critério de aceite 5)

        Scenario: Registrar um usuário com mais de 60 caracteres no email
            And request { name: "Vitor Galinari", email: "vitorvitorvitorvitorvitor@galinarigalinarigalinarigalinar.com"}
            When method post
            Then status 400
        #Não deve ser possível cadastrar um usuário com um email com mais de 60 caracteres, me retornando um response code 400. (Critério de aceite 6)
