require_relative 'db_connection'
require 'active_support/inflector'
# NB: the attr_accessor we wrote in phase 0 is NOT used in the rest
# of this project. It was only a warm up.

class SQLObject
  def self.columns
    if @columns
      @columns
    else
      columns = DBConnection.execute2(<<-SQL)
        SELECT * FROM #{self.table_name}
      SQL
      @columns = columns.first.map(&:to_sym)
    end
  end

  def self.finalize!
    self.columns.each do |col|
      define_method(col) { attributes[col] }
      
      define_method("#{col}=") do |val|
        attributes[col] = val
      end
    end
  end

  def self.table_name=(table_name)
    @table_name = table_name
  end

  def self.table_name
    @table_name || self.to_s.tableize
  end

  def self.all
    rows = DBConnection.execute(<<-SQL)
      SELECT #{self.table_name}.* FROM #{self.table_name}
    SQL

    self.parse_all(rows)
  end

  def self.parse_all(results)
    results.map {|result| self.new(result)}
  end

  def self.find(id)
    row = DBConnection.execute(<<-SQL, id)
      SELECT
        #{self.table_name}.*
      FROM
        #{self.table_name}
      WHERE
        #{self.table_name}.id = ?
    SQL

    row.empty? ? nil : self.parse_all(row).first
  end

  def initialize(params = {})
    params.each do |attr_name, value|
      unless self.class.columns.include?(attr_name.to_sym)
        raise "unknown attribute '#{attr_name}'"
      end

      send("#{attr_name}=".to_sym, value)
    end
  end

  def attributes
    @attributes ? @attributes : @attributes = {}
  end

  def attribute_values
    self.class.columns.map do |val|
      self.send(val)
    end
  end

  def insert
    columns = self.class.columns.drop(1)
    col_names = columns.map(&:to_s).join(", ")
    question_marks = (["?"] * columns.length).join(", ")

    DBConnection.execute(<<-SQL, *attribute_values.drop(1))
      INSERT INTO
        #{self.class.table_name} (#{col_names})
      VALUES
        (#{question_marks})
    SQL

    self.id = DBConnection.last_insert_row_id
  end

  def update
    columns = self.class.columns.drop(1)
    attributes = columns.map {|col| "#{col} = ?"}.join(", ")

    DBConnection.execute(<<-SQL, *attribute_values.rotate)
      UPDATE
        #{self.class.table_name}
      SET
        #{attributes}
      WHERE
        id = ?
    SQL
  end

  def save
    self.id.nil? ? insert : update
  end
end
