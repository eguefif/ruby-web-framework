# frozen_string_literal: true

require './bin/sql_command_generator'

describe SQLCommandGenerator do
  describe '.create_table' do
    context 'given no name and no fields' do
      it 'returns error' do
        expect(SQLCommandGenerator.create_table('')).to eq('error')
      end
    end

    context 'given n simple name and no fields' do
      it 'returns CREATE TABLE helloworld();' do
        expect(SQLCommandGenerator.create_table('helloworld')).to eq('CREATE TABLE helloworld();')
      end
    end

    context 'given n simple name and a string' do
      it 'returns CREATE TABLE helloworld(field1 TEXT);' do
        fields = [{ 'name' => 'field1', 'type' => 'text' }]
        expected_value = 'CREATE TABLE helloworld(field1 TEXT);'
        expect(SQLCommandGenerator.create_table('helloworld', fields)).to eq(expected_value)
      end
    end

    context 'given n simple name a int, a varchar, and a string' do
      it 'returns CREATE TABLE helloworld(field1 TEXT, field2 INT, field3 VARCHAR(30);' do
        fields = [
          { 'name' => 'field1', 'type' => 'text' },
          { 'name' => 'field2', 'type' => 'int' },
          { 'name' => 'field3', 'type' => 'varchar' }
        ]
        expected_value = 'CREATE TABLE helloworld(field1 TEXT, field2 INT, field3 VARCHAR(30));'
        expect(SQLCommandGenerator.create_table('helloworld', fields)).to eq(expected_value)
      end
    end

    context 'given n simple name a int, a varchar with a size, and a string' do
      it 'returns CREATE TABLE helloworld(field1 TEXT, field2 INT, field3 VARCHAR(30);' do
        fields = [
          { 'name' => 'field1', 'type' => 'text' },
          { 'name' => 'field2', 'type' => 'int' },
          { 'name' => 'field3', 'type' => 'varchar', 'size' => 35 }
        ]
        expected_value = 'CREATE TABLE helloworld(field1 TEXT, field2 INT, field3 VARCHAR(35));'
        expect(SQLCommandGenerator.create_table('helloworld', fields)).to eq(expected_value)
      end
    end
  end

  describe '.select_all' do
    context 'given a name' do
      it 'returns select all' do
        expect(SQLCommandGenerator.select_all('hello')).to eq('SELECT * FROM hello;')
      end
    end
  end

  describe '.insert' do
    context 'given a name and cols' do
      it 'returns ok' do
        data = [
          { 'type' => 'name', 'value' => 'hello' },
          { 'type' => 'id', 'value' => 5 },
          { 'type' => 'surname', 'value' => 'world' }
        ]
        expected_value = "INSERT INTO hello (name, id, surname) VALUES ('hello', '5', 'world');"
        expect(SQLCommandGenerator.insert('hello', data)).to eq(expected_value)
      end
    end
  end
end
