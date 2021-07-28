Quando('envio um GET com o CEP 11712-510') do
  @received = Viacep.get('/11712510/json')
end

Quando('envio um GET com o CEP 11712-510') do
  @received = Viacep.get('/24241001/json')
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
  expect(@received.code).to eql 200
  @massa.all? do |key, value|
    expect(@received[key.to_s]).to eql(value)
    # puts "Expected #{key}: #{value}    Received: #{received.parsed_response[key.to_s]}"
  end
  # expect(@massa.all? { |key, value| @received[key.to_s].eql?(value) }).to be_truthy
  # puts "Code for SP: #{received.code}"
end