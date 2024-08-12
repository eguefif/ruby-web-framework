# frozen_string_literal: true

# db engine
class DBEngine
  def initialize(db_driver)
    @db = db_driver
  end

  def create_table(name, cols = [])
    return 'error' if cols.empty?

    command = SQLCommandGenerator.create_table(name, cols)
    puts command
    @db.execute(command)
  end

  def drop_table(name, cols = [])
    command = SQLCommandGenerator.drop_table name
    puts "Executing: #{command}"
    @db.execute(command)
  end

  def insert(name, data)
    command = SQLCommandGenerator.insert(name, data)
    @db.execute(command)
  end

  def select_all(table)
    command = SQLCommandGenerator.select_all(table)
    puts command
    @db.execute(command)
  end

  def reset
    @db.reset
  end
end
