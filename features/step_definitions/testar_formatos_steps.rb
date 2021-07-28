Quando('envio um GET com um cep válido e solicito a resposta em dado {string}') do |formato|
  @piped_format = /.\|/
  @querty_format = /.&/
  @json_format = /\{\s./
  @xml_format = /xml/
  case formato
  when 'json'
    @received = Viacep.get('/11712510/json')
    expect(@received.body.match?(@json_format)).to be_truthy
    expect(@received.body.match?(@xml_format)).to be_falsey
    expect(@received.body.match?(@querty_format)).to be_falsey
    expect(@received.body.match?(@piped_format)).to be_falsey
  when 'xml'
    @received = Viacep.get('/11712510/xml')
    expect(@received.body.match?(@xml_format)).to be_truthy
    expect(@received.body.match?(@querty_format)).to be_falsey
    expect(@received.body.match?(@piped_format)).to be_falsey
    expect(@received.body.match?(@json_format)).to be_falsey
  when 'querty'
    @received = Viacep.get('/11712510/querty')
    expect(@received.body.match?(@querty_format)).to be_truthy
    expect(@received.body.match?(@xml_format)).to be_falsey
    expect(@received.body.match?(@piped_format)).to be_falsey
    expect(@received.body.match?(@json_format)).to be_falsey
  else
    @received = Viacep.get('/11712510/piped')
    expect(@received.body.match?(@piped_format)).to be_truthy
    expect(@received.body.match?(@json_format)).to be_falsey
    expect(@received.body.match?(@querty_format)).to be_falsey
    expect(@received.body.match?(@xml_format)).to be_falsey
  end
end

Então('devo receber dados válidos com a formatação correta') do
    expect(@received.code).to eql(200)
  end
