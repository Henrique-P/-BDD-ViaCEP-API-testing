#language: pt

Funcionalidade: Testar a API Viacep

  @test_sp
  Cenario: Enviar um CEP de São Paulo
    Quando envio um GET com o CEP 01311-200
    Então devo receber dados válidos
  
  @test_rj
  Cenario: Enviar um CEP do Rio de Janeiro
    Quando envio um GET com o CEP 22010-000
    Então devo receber dados válidos
  
  @validar_varios_ceps
  Esquema do Cenário: Validar CEP de diferentes logradouros
    Quando envio um GET com um CEP de <localidade>
    Então devo receber dados válidos
  
    Exemplos:
    | localidade       |
    | 'sao_paulo'      |
    | 'rio_de_janeiro' |
    | 'minas_gerais'   |

  @busca_por_endereço
  Cenário: Validar a resposta da API ao buscar por um logradouro
    Quando solicito dados refente a Avenida Atlântica
    Então devo receber dados válidos do cep

  @teste_negativo
  Esquema do Cenário: Validar o codigo HTTP após fornecer entradas inválidas
    Quando envio um GET com um <cep_invalido>
    Então devo receber código '400'
  
    Exemplos:
    | cep_invalido |
    | '000000'     |
    | '0000000'    |
    | 'a'          |
    | '1234567'    |

  @teste_de_formatos
  Esquema do Cenário: Validar a mesma resposta em JSON, Querty, XML e Piped
    Quando envio um GET com um cep válido e solicito a resposta em dado <formato>
    Então devo receber dados válidos com a formatação correta
  
    Exemplos:
    | formato  |
    | 'json'   |
    | 'xml'    |
    | 'piped'  |
    | 'querty' |