require 'rspec'
require 'simplecov'
require 'rack/test'

SimpleCov.start do
  add_filter '/spec/'
end

ENV['RACK_ENV'] = 'test'

module RSpecMixin
  include Rack::Test::Methods
  def app() Sinatra::Application end
end

RSpec.configure do |config|
    config.include RSpecMixin
end
