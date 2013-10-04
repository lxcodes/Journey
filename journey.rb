# journey.rb
require 'sinatra/base'
require 'sinatra/json'

Mongoid.load!('./config/mongoid.yml')

# Models
class Service
  include Mongoid::Document
end

class Protocol
end

class Credentials
  include Mongoid::Document
  field :key
end

# Journey Application
configure do
  enable :logging
  set :server, :puma

  file = File.new("#{settings.root}/log/#{settings.environment}.log", 'a+')
  file.sync = true
  use Rack::CommonLogger, file

  Thread.new {
      EM.run {
        logger.info "Starting EventMachine Reactor"
        EM::add_periodic_timer 1.0 do

        end
        EM.error_handler{ |e|
          logger.error "Error raised during event loop: #{e.message}"
          logger.error e.backtrace unless e.backtrace.nil?
        }
      }
    }
end

class Journey < Sinatra::Base

  helpers Sinatra::JSON

  get '/' do
    json ping: 'pong'
  end

  not_found do
    json error: 'not-found'
  end
end
