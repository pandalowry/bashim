require_relative 'lib/database_installer'

DatabaseInstaller::create_database unless File::exists? 'bashim.sqlite3'  #создаем БД