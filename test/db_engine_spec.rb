# frozen_string_literal: true

require './bin/db_engine'
require './bin/db_driver_sqlite'

describe 'DBEngine' do
  describe '.create_table' do
    context 'given the creation of a table helloworld' do
      it 'returns a number of rows > 0' do
        driver = DBDriverSqlite.new(memory: true)
        db = DBEngine.new(driver)
        fields = [
          { 'name' => 'title', 'type' => 'varchar', 'size' => 20 },
          { 'name' => 'abstract', 'type' => 'text' }
        ]
        db.create_table('helloworld', fields)
        begin
          db.select_all('helloworld')
        rescue SQLite3::SQLException => e
          message = e.message
        else
          message = 'ok'
        end

        expect(message).not_to start_with('no such table')
      end
    end
  end
end
