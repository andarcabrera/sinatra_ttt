require './ttt'

configure do
  enable :sessions
  set :session_secret, ENV['SESSION_SECRET'] || 'anda secret'

  set :views, File.join(Sinatra::Application.root, "views")
end

run Sinatra::Application
