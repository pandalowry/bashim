require_relative 'lib/database_installer'

DatabaseInstaller.create_database unless File::exists? 'bashim.sqlite3'  #создаем БД
DatabaseInstaller::fill_database_from_bash #заполняем БД
