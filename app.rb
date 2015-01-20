require 'rubygems'
require 'bundler/setup'
require 'sinatra/base'
require 'sinatra/json'
require 'sequel'
require 'json'
require 'sinatra/sequel'
require 'logger'

# setup

## database
class MyApp < Sinatra::Base
  register Sinatra::SequelExtension

  set :database, 'sqlite://transactions.db'
end

## migrations
class MyApp < Sinatra::Base
  migration 'create transactions table' do
    database.create_table :transactions do
      primary_key :id
      String :action
      String :vendor
      String :category
      String :method
      Integer :amount
      Integer :balance
      DateTime :timestamp
    end
  end

  migration 'create categories table' do
    database.create_table :categories do
      primary_key :id
      String :name
      Integer :budget
    end
  end
end

## base
class MyApp < Sinatra::Base
  database.loggers << Logger.new($stdout)

  helpers Sinatra::JSON

  helpers do
    def json_hash
      return @json_hash unless @json_hash.nil?

      @json_hash = JSON.parse(
        request.env['rack.input'].gets, symbolize_names: true
      )
    rescue
      {}
    end
  end
end

# models
Sequel::Model.plugin :validation_helpers
Sequel::Model.plugin :json_serializer

class Transaction < Sequel::Model(:transactions)
  def validate
    super
    validates_presence [:amount]
  end
end

class Category < Sequel::Model(:categories)
  def validate
    super
    validates_presence [:name]
  end
end

# controllers

## transactions
class MyApp < Sinatra::Base
  get '/transactions' do
    @list = Transaction.all
    json @list
  end

  post '/transactions' do
    json_hash[:amount] = (json_hash[:amount] * 100).to_i
    json_hash[:balance] = (json_hash[:balance] * 100).to_i
    json_hash[:timestamp] = json_hash[:@timestamp]

    @transaction = Transaction.new
    @transaction.set_fields(json_hash, [:action, :vendor, :method, :amount, :balance, :timestamp])

    halt 400, json(errors: @transaction.errors) unless @transaction.valid?

    @transaction[:category] = 'test'

    @transaction.save

    [201, @transaction.to_json(:except=>[:method])]
  end
end

## categories
class MyApp < Sinatra::Base
  get '/categories' do
    @list = Category.all
    json @list
  end

  post '/categories' do
    json_hash[:budget] = json_hash[:budget] * 100

    @category = Category.new
    @category.set_fields(json_hash, [:name, :budget])

    halt 400, json(errors: @category.errors) unless @category.valid?

    @category.save

    [201, json(@category)]
  end
end
