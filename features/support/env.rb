require 'cucumber'
require 'rspec'
require 'httparty'
require 'pry'

module Viacep
  include HTTParty
  base_uri 'viacep.com.br/ws'
end