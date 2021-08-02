Quando('envio um GET com o CEP 01311-200') do
  @received = Viacep.get('/01311200/json') # faz a requisição e guarda a resposta dentro da variavel 'received'
  @massa = @app.massa_sp # faz a seleção da massa correta para validação
end

Quando('envio um GET com o CEP 22010-000') do
  @received = Viacep.get('/22010000/json') # faz a requisição e guarda a resposta dentro da variavel 'received'
  @massa = @app.massa_rj # faz a seleção da massa correta para validação
end

# bloco referente ao @validar_varios_ceps
Quando('envio um GET com um CEP de {string}') do |localidade|
  # bloco de seleção da massa para validação
  @massa = case localidade
           when 'sao_paulo'
             @app.massa_sp # a variavel massa recebe os dados corretos para validação
           when 'rio_de_janeiro'
             @app.massa_rj
           when 'minas_gerais'
             @app.massa_mg
           end
  @received = Viacep.get("/#{@massa[:cep]}/json") # com a massa selecionada, é feita a requisição, e a resposta guardada dentro da variavel 'received'
end

Então('devo receber dados válidos') do
  expect(@received.code).to eql(200) # instrução para validar o codigo HTTP recebido
  @massa.all? do |key, value| # laço para validar cada dado do json com cada chave e valor do hash de massa
    expect(@received[key.to_s]).to eql(value)
  end
end

# bloco refente ao @busca_por_endereço
Quando('solicito dados refente a Avenida Atlântica') do
  @received = Viacep.get('/rj/rio%20de%20janeiro/avenida%20atlantica/json') # faz a requisição conforme o formato esperado pela API e guarda a resposta dentro da variavel 'received'
end

Então('devo receber dados válidos do cep') do
  expect(@received.code).to eql(200) # instrução para validar o codigo HTTP recebido
  # @app.massa_rj.all? do |key, value| # laço para validar cada dado do json com cada chave e valor do hash de massa

  # end
end

# bloco refente ao teste negativo
Quando('envio um GET com um {string}') do |cep_invalido|
  @received = Viacep.get("/#{cep_invalido}/json") # instrução que faz a solicitação com um dos ceps inválidos descritos no esquema de cenário
end

Então('devo receber código {string}') do |code|
  expect(@received.code).to eql(code.to_i) #validação do codigo HTTP recebido
end