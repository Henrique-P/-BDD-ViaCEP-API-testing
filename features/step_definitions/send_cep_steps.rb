Quando('envio um GET com o CEP 11712-510') do
  @received = Viacep.get('/11712510/json')
  @massa = @app.massa_sp
end

Quando('envio um GET com o CEP 24241-001') do
  @received = Viacep.get('/24241001/json')
  @massa = @app.massa_rj
end

Quando('envio um GET com um CEP de {string}') do |localidade|
  @massa = case localidade
           when 'sao_paulo'
             @app.massa_sp
           when 'rio_de_janeiro'
             @app.massa_rj
           when 'minas_gerais'
             @app.massa_mg
           end
  @received = Viacep.get("/#{@massa[:cep]}/json")
end

Então('devo receber dados válidos') do
  expect(@received.code).to eql(200)
  @massa.all? do |key, value|
    expect(@received[key.to_s]).to eql(value)
    # puts "Expected #{key}: #{value}    Received: #{@received.[key.to_s]}"
  end
  # expect(@massa.all? { |key, value| @received[key.to_s].eql?(value) }).to be_truthy
  puts "HTML code received: #{@received.code}"
end


Quando('envio um GET com um {string}') do |cep_invalido|
  @received = Viacep.get("/#{cep_invalido}/json")
end

Então('devo receber código {string}') do |code|
  expect(@received.code).to eql(code.to_i)
end