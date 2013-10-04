require 'rubygems'
require 'bundler'

Bundler.require

require './journey'

use Rack::ShowExceptions

run Journey
