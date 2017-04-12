require "sqlite3"
require_relative "bash_parser"

class DatabaseInstaller
  def self.create_database #создает саму БД и ее структуру
    db = SQLite3::Database.new "bashim.sqlite3"

    rows = db.execute <<-SQL
      CREATE TABLE "posts" (
          "number" INTEGER PRIMARY KEY NOT NULL,
          "ratio" INTEGER DEFAULT ('NULL'),
          "datetime" TEXT NOT NULL,
          "text" TEXT NOT NULL
      );
    SQL
  end

  def self.fill_database_from_bash #заполняет БД данными с http://bash.im
    parser = BashParser.new
  end 
  
  
end