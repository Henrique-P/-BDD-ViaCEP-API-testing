#language: pt

Funcionalidade: Testar a API Viacep

  @test
  Cenario: Enviar um CEP de São Paulo
    Quando envio um GET com o CEP 11712-510
    Então devo receber dados válidos
  
  @test2
  Cenario: Enviar um CEP do Rio de Janeiro
    Quando envio um GET com o CEP 
    Então devo receber dados válidos
  
  @validar_varios_ceps
  Esquema do Cenário: Validar CEP de diferentes logradouros
    Quando envio um GET com um CEP de <localidade>
    Então devo receber dados válidos
  
    Exemplos:
    |    localidade    |
    |   'sao_paulo'    |
    | 'rio_de_janeiro' |
    |  'minas_gerais'  |