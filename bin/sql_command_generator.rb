# frozen_string_literal: true

# sets of functions that create sql command
module SQLCommandGenerator
  # Helper class that generate sql command
  class TableBuilder
    def initialize(name, cols)
      @name = name
      @cols = cols
    end

    def generate
      cmd = "CREATE TABLE #{@name}("
      @cols.each_with_index do |col, index|
        cmd += get_col(col)
        cmd += ', ' if index != @cols.length - 1
      end
      "#{cmd});"
    end

    private

    def get_col(col)
      retval = col.key?('name') ? col['name'].to_s : ''
      size = col.key?('size') ? col['size'].to_s : '30'
      case col['type']
      when 'varchar'
        return "#{retval} VARCHAR(#{size})"
      when 'text'
        return "#{retval} TEXT"
      when 'int'
        return "#{retval} INT"
      end
      ''
    end
  end

  def self.create_table(name, cols = [])
    return 'error' if name.length == 0

    table_builder = TableBuilder.new(name, cols)
    table_builder.generate
  end

  def self.drop_table(name)
    return 'error' if name.length == 0

    "DROP TABLE #{name};"
  end

  def self.insert(name, data)
    return 'error' unless name.length.positive?

    command = "INSERT INTO #{name} ("
    data.each_with_index do |datum, index|
      command += datum['type']
      command += if index == data.length - 1
                   ') VALUES ('
                 else
                   ', '
                 end
    end
    data.each_with_index do |datum, index|
      command += "'#{datum['value']}'"
      command += if index == data.length - 1
                   ');'
                 else
                   ', '
                 end
    end
    command
  end

  def self.select_all(name)
    return 'error' if name.length == 0

    "SELECT * FROM #{name};"
  end
end
