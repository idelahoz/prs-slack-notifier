if ENV['ENVIROMENT'] == 'production'
  # production config
else
  require 'dotenv'

  Dotenv.load
end