require 'sinatra'
require 'sqlite3'
require 'sinatra/reloader'
require 'sinatra/activerecord'
# подключились к базе данных\создали новую
set :database, {adapter: "sqlite3", database: "barbershop.sqlite3"}
# создаем новую сушность для обьекта Client
class Client < ActiveRecord::Base

end

class Barber < ActiveRecord::Base

end

def herb(template, options={}, locals={})
  render "html.erb", template, options, locals
end

configure do
  Tilt.register Tilt::ERBTemplate, 'html.erb'
end

before do
  @barbers = Barber.all
end

get '/' do

  herb :index
end
post '/' do
  @name = params[:name]
  @phone = params[:phone]
  @dateshop = params[:dateshop]
  @barber = params[:barber]
  @color = params[:color]
  # запись иноформации в БД при помощи ORM
  # name, phone, datestamp, barber, color
  # не хочу делать через оперативную лучше сразу в БД все кидать
  Client.create(
  name: @name,
  phone: @phone,
  datestamp: @dateshop,
  barber: @barber,
  color: @color)

  herb("Спасибо ваша заявка принята в обработку")
end