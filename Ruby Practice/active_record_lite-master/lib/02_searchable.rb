require_relative 'db_connection'
require_relative '01_sql_object'

module Searchable
  def where(params)
    where_line = params.keys.map do |attr_name|
      "#{attr_name} = ?"
    end
    where_line = where_line.join(" AND ")

    rows = DBConnection.execute(<<-SQL, params.values)
    SELECT
      *
    FROM
      #{self.table_name}
    WHERE
      #{where_line}
    SQL

    rows.map do |row|
      self.new(row)
    end
  end
end

class SQLObject
  extend Searchable
end
