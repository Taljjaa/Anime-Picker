require 'bundler'
Bundler.require

ActiveRecord::Base.establish_connection(adapter: 'sqlite3', database: 'db/development.db')
# require_all '../models'
require_all 'models'

ActiveRecord::Base.logger = nil
