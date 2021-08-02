Quando('envio um GET com um cep válido e solicito a resposta em dado {string}') do |formato|
  formato_piped = /.\|/
  formato_querty = /.&/
  formato_json = /(?:\{\s)/ # /\{\s./
  formato_xml = /xml/
  case formato
  when 'json'
    @received = Viacep.get('/01311200/json')
    expect(@received.body.match?(formato_json)).to be_truthy
    expect(@received.body.match?(formato_xml)).to be_falsey
    expect(@received.body.match?(formato_querty)).to be_falsey
    expect(@received.body.match?(formato_piped)).to be_falsey
  when 'xml'
    @received = Viacep.get('/01311200/xml')
    expect(@received.body.match?(formato_xml)).to be_truthy
    expect(@received.body.match?(formato_querty)).to be_falsey
    expect(@received.body.match?(formato_piped)).to be_falsey
    expect(@received.body.match?(formato_json)).to be_falsey
  when 'querty'
    @received = Viacep.get('/01311200/querty')
    expect(@received.body.match?(formato_querty)).to be_truthy
    expect(@received.body.match?(formato_xml)).to be_falsey
    expect(@received.body.match?(formato_piped)).to be_falsey
    expect(@received.body.match?(formato_json)).to be_falsey
  else
    @received = Viacep.get('/01311200/piped')
    expect(@received.body.match?(formato_piped)).to be_truthy
    expect(@received.body.match?(formato_json)).to be_falsey
    expect(@received.body.match?(formato_querty)).to be_falsey
    expect(@received.body.match?(formato_xml)).to be_falsey
  end
end

Então('devo receber dados válidos com a formatação correta') do
    expect(@received.code).to eql(200)
  end
