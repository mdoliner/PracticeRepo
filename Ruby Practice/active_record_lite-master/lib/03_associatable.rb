require_relative '02_searchable'
require 'active_support/inflector'

# Phase IIIa
class AssocOptions
  attr_accessor(
    :foreign_key,
    :class_name,
    :primary_key
  )

  def model_class
    @class_name.constantize
  end

  def table_name
    model_class.table_name
  end
end

class BelongsToOptions < AssocOptions
  def initialize(name, options = {})
    @foreign_key = options[:foreign_key] || "#{name.to_s.singularize}_id".to_sym
    @primary_key = options[:primary_key] || :id
    @class_name = options[:class_name] || name.to_s.camelcase
  end
end

class HasManyOptions < AssocOptions
  def initialize(name, self_class_name, options = {})
    @foreign_key = options[:foreign_key] || "#{self_class_name.downcase.singularize}_id".to_sym
    @primary_key = options[:primary_key] || :id
    @class_name = options[:class_name] || name.singularize.camelcase
  end
end

module Associatable
  # Phase IIIb
  def belongs_to(name, options = {})
    assoc_options[name] = BelongsToOptions.new(name, options)
    define_method(name) do
      foreign_key = self.class.assoc_options[name].send(:foreign_key)
      model_class = self.class.assoc_options[name].model_class
      primary_key = self.class.assoc_options[name].send(:primary_key)
      model_class.where("#{primary_key}" => self.send(foreign_key)).first
    end
  end

  def has_many(name, options = {})
    options = HasManyOptions.new(name.to_s, self.to_s, options)
    define_method(name) do
      foreign_key = options.send(:foreign_key)
      model_class = options.model_class
      primary_key = options.send(:primary_key)
      model_class.where("#{foreign_key}" => self.send(primary_key))
    end
  end

  def assoc_options
    @assoc_options ||= {}
  end
end

class SQLObject
  extend Associatable
end
