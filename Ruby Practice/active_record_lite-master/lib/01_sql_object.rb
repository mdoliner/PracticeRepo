require_relative 'db_connection'
require 'active_support/inflector'
# NB: the attr_accessor we wrote in phase 0 is NOT used in the rest
# of this project. It was only a warm up.

class SQLObject
  def self.columns
    columns = DBConnection.execute2(<<-SQL).first
    SELECT
      *
    FROM
      #{self.table_name}
  SQL

  columns.map { |column| column.to_sym }
  end

  def self.finalize!
    self.columns.each do |column|
      define_method(column) { attributes[column] }
      define_method("#{column}=") { |value| attributes[column] = value }
    end
  end

  def self.table_name=(table_name)
    @table_name = table_name
  end

  def self.table_name
    @table_name ||= self.to_s.tableize
  end

  def self.all
    rows = DBConnection.execute(<<-SQL)
      SELECT
        *
      FROM
        #{self.table_name}
    SQL
    self.parse_all(rows)
  end

  def self.parse_all(results)
    objects = []
    results.each do |result|
      objects << self.new(result)
    end
    objects
  end

  def self.find(id)
    row = DBConnection.execute(<<-SQL, id).first
    SELECT
      *
    FROM
      #{self.table_name}
    WHERE
      id = ?
    SQL
    return nil if row.nil?
    self.new(row)
  end

  def initialize(params = {})
    params.each do |attr_name, attr_value|
      unless self.class.columns.include?(attr_name.to_sym)
        raise "unknown attribute '#{attr_name}'"
      end
      self.send("#{attr_name}=", attr_value)
    end
    self
  end

  def attributes
    @attributes ||= {}
  end

  def attribute_values
    self.class.columns.map do |column|
      self.send(column)
    end
  end

  def save
    if self.id.nil?
      self.insert
    else
      self.update
    end
  end

  def insert
    columns = self.class.columns
    col_names = columns.map(&:to_s).join(", ")
    question_marks = (["?"] * columns.length).join(", ")
    DBConnection.execute(<<-SQL, *attribute_values)
      INSERT INTO
        #{self.class.table_name} (#{col_names})
      VALUES
        (#{question_marks})
    SQL
    self.id = DBConnection.last_insert_row_id
  end

  def update
    set_line = self.class.columns.map do |column|
      "#{column} = ?"
    end
    set_line = set_line.join(", ")
    DBConnection.execute(<<-SQL, *attribute_values)
      UPDATE
        #{self.class.table_name}
      SET
        #{set_line}
      WHERE
        id = #{self.id}
    SQL
  end

end