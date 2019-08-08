#encoding: utf-8
require 'rubygems'
require 'sinatra'
require 'sinatra/reloader'
require 'sqlite3'
require 'pry'

db = SQLite3::Database.new 'barbershop.db'

configure do
  db.execute 'CREATE TABLE IF NOT EXISTS "users"
  	(
    	  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
        "username" TEXT,
      	"phone" TEXT,
       	"datestamp" TEXT,
      	"barber" TEXT,
      	"color" TEXT
		)'
end


get '/' do
	# erb "Hello! <a href=\"https://github.com/bootstrap-ruby/sinatra-bootstrap\">Original</a> pattern has been modified for <a href=\"http://rubyschool.us/\">Ruby School</a>!!!"
  @users = db.execute( "select * from users" )
  erb :index
end

get '/about' do
	erb :about
end

get '/visit' do
	erb :visit
end

post '/visit' do
	@username = params[:username]
	@phone = params[:phone]
	@datetime = params[:datetime]
	@barber = params[:barber]
	@color = params[:color]

	hh = { :username => 'Введите имя',
		   :phone => 'Введите номер телефона',
		   :datetime => 'Введите дату и время'}

	@error = hh.select {|key, _| params[key] == ""}.values.join(",")

		if @error != ''
			return erb :visit
    end

	db = SQLite3::Database.new 'barbershop.db'
  db.execute 'insert into users (username, phone, datestamp, barber, color) values (?,?,?,?,?)', [@username,@phone,@datetime,@barber,@color]

	@message = "Отлично! Уважаемый #{@username}, мы ждем вас в Barber Shop в #{@datetime} к #{@barber}! Цвет окрашивания: #{@color}"

	erb :message
end

#def get_db
	#return SQLite3::Database.new 'barbershop.db'
#end


get '/contacts' do
	erb :contacts

end



get '/success' do
 	erb 'Спасибо за ваше обращение. Мы обязательно ответим на него в ближайшее время.'

end

get '/admin' do
	erb :pass

end
