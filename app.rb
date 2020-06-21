require 'sinatra'
require 'sqlite3'
require 'sinatra/reloader'
require 'sinatra/activerecord'
# подключились к базе данных\создали новую
set :database, {adapter: "sqlite3", database: "barbershop.sqlite3"}
# создаем новую сушность для обьекта Client
class Client < ActiveRecord::Base
  # вызываем метод валидации в котором мы указываем что мы будем проверять
  # параметр имя на наличие  пареметр имени просотое значение
  validates( :name, presence: true)
  validates( :phone, presence: true)
  validates( :datestamp, presence: true)
  validates( :color, presence: true)
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
  # новый экземпляр класса
  c = Client.new params[:client]
  c.save

  if c.save
    herb('Спасибо ваша заявка была принята в обработку')
  else
    ('Ошибка ')
  end
end