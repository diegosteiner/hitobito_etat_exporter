require_relative 'role_visitor'
require_relative 'clean_visitor'

class Transformer
  attr_accessor :data

  def initialize(data)
    @original_data = data.freeze
    @data = data.dup
    @visitors = [RoleVisitor.new, CleanVisitor.new]
  end

  def call
    transform
    sort
    data
  end

  def transform
    @visitors.each do |visitor|
      @data = @data.map do |row|
        visitor.visit(row)
      end.flatten.compact
    end
  end

  def sort
    @data.sort! do |a, b|
      a['RolePos'] <=> b['RolePos'] || a['Pfadiname'] <=> b['Pfadiname']
    end
  end
end
