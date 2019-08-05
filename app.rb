#encoding: utf-8
require 'rubygems'
require 'sinatra'
require 'sinatra/reloader'

get '/' do
	erb "Hello! <a href=\"https://github.com/bootstrap-ruby/sinatra-bootstrap\">Original</a> pattern has been modified for <a href=\"http://rubyschool.us/\">Ruby School</a>!!!"			
end

get '/about' do
	@error = 'smth wrong!'
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
	
	if @username == ''
		@error = 'Введите имя'
	end	

	if @phone == ''
		@error = 'Введите номер телефона'
	end
	if @datetime == ''
		@error = 'Введите дату и время'
	end

	if @error != ''
		return erb :visit
	end

	@message = "Отлично! Уважаемый #{@username}, мы ждем вас в Barber Shop в #{@datetime} к #{@barber}! Цвет окрашивания: #{@color} "



	@f = File.open "./public/users.txt", "a"
	@f.write "Клиент: #{@username}, Телефон: #{@phone}, Дата и время: #{@datetime}, Парикмахер: #{@barber}, Цвет окрашивания: #{@color} "
	@f.close

	erb :message

	
end

get '/contacts' do
	erb :contacts
end 

post '/contacts' do
	@email = params[:email]
	@msg = params[:msg]

	@message = "Спасибо за ваше обращение. Мы обязательно ответим на него в ближайшее время."
	

	@c = File.open "./public/contacts.txt", "a"
	@c.write "email: #{@email}, Сообщение: #{@msg}"
	@c.close

	erb :message
end

get '/admin' do

	@title = "Information for admin"
	
	
	
	erb :pass
		

end

post '/admin' do
	@login = params[:aaa]
	@password = params[:bbb]

	if @login == 'admin' && @password == 'secret'
		
		@f = File.open("./public/users.txt").read
		@c = File.open("./public/contacts.txt").read
		
	elsif @login == 'admin' && @password == 'admin'
		@message = 'Отличная попытка! Доступ запрещен!'
		erb :pass
	
	else  
		@message = 'Доступ запрещен'
		erb :pass
	end
end