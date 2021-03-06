require_relative '03_associatable'

# Phase IV
module Associatable
  # Remember to go back to 04_associatable to write ::assoc_options

  def has_one_through(name, through_name, source_name)
    define_method(name) do
      through_options = self.class.assoc_options[through_name]
      source_options = through_options.model_class.assoc_options[source_name]
      source_table = source_options.model_class.table_name
      through_table = through_options.model_class.table_name
      foreign_key = through_options.send(:foreign_key)
      row = DBConnection.execute(<<-SQL, self.send(foreign_key)).first
        SELECT
          #{source_table}.*
        FROM
          #{through_table}
        JOIN
          #{source_table}
        ON
          #{through_table}.#{source_options.send(:foreign_key)} =
          #{source_table}.#{source_options.send(:primary_key)}
        WHERE
          #{through_table}.#{through_options.send(:primary_key)} = ?
      SQL

      source_options.model_class.new(row)
    end
  end
end
