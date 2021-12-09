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
    class_name.constantize
  end

  def table_name
    class_name.underscore.pluralize
  end
end

class BelongsToOptions < AssocOptions
  def initialize(name, options = {})
    @foreign_key = options[:foreign_key] || "#{name}_id".to_sym
    @class_name = options[:class_name] || "#{name}".camelcase
    @primary_key = :id
  end
end

class HasManyOptions < AssocOptions
  def initialize(name, self_class_name, options = {})
    @foreign_key = options[:foreign_key] || "#{self_class_name.underscore}_id".to_sym
    @class_name = options[:class_name] || "#{name}".singularize.camelcase
    @primary_key = :id
  end
end

module Associatable
  # Phase IIIb
  def belongs_to(name, options = {})
    options = BelongsToOptions.new(name, options)
    assoc_options[name] = options

    define_method(name) do
      foreign_key_value = send(options.foreign_key)

      options.model_class
             .where(options.primary_key => foreign_key_value)
             .first
    end
  end

  def has_many(name, options = {})
    self_class_name = "#{self}".camelcase.singularize
    options = HasManyOptions.new(name, self_class_name, options)

    define_method(name) do
      primary_key_value = send(options.primary_key)
      
      options.model_class
             .where(options.foreign_key => primary_key_value)
    end
  end

  def assoc_options
    @assoc_options ||= {}
  end
end

class SQLObject
  extend Associatable
end
