require "sqlite3"
require_relative "bash_parser"

class DatabaseInstaller
  
  def self.db
    db = SQLite3::Database.new "bashim.sqlite3"
  end

  def self.create_database #создает саму БД и ее структуру    
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
    parser.posts.each do |post|
      begin
        db.execute("INSERT INTO posts (number, ratio, datetime, text) 
            VALUES (?, ?, ?, ?)", [post.number, post.ratio.nil? ? 'NULL' : post.ratio, post.date, post.text])  
      rescue SQLite3::ConstraintException #если БД уже создана и там есть записи, но уникальность не дает вставить повторяющуюся - пропускаем дубль
        next  
      end      
    end
  end 
  
  
end