# frozen_string_literal: true

require 'sinatra'
require 'sinatra/jbuilder'
require 'sequel'
require 'will_paginate/array'
require_relative './helpers/number'
require_relative './db/db'
require_relative './models/init'
require './app'

run Sinatra::Application
