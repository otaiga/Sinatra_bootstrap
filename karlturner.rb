require "rubygems"
require "sinatra"

  get '/' do
  	@notification = nil
  	erb :index
  end

  get '/contact' do
  	erb :contact
  end

  post '/contact' do
    require 'pony'
    name = ENV["NAME"]
    pass = ENV["PASS"]

    Pony.mail(
      :from => params[:name] + "<" + params[:email] + ">",
      :to => name,
      :subject => params[:name] + " has contacted you via your website.",
      :body => params[:message],
      :port => '587',
      :via => :smtp,
      :via_options => { 
        :address              => 'smtp.gmail.com', 
        :port                 => '587', 
        :enable_starttls_auto => true, 
        :user_name            => name,
        :password             => pass,
        :authentication       => :plain, 
        :domain               => 'localhost.localdomain'
      })
    redirect '/success' 
  end


  get('/success') do
  	@notification = "Thanks for your email. I'll be in touch soon."
  	 erb :index
  end
