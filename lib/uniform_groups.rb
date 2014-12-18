require 'active_support/core_ext/enumerable'
require 'active_support/core_ext/hash/slice'

require 'uniform_groups/array_grouper'

# source must be a Hash with Array values
#   hash = {
#     "A" => %w(Armenia Austria),
#     "B" => %w(Belgium),
#     "C" => %w(Canada China Cuba)
#   }
#   groups = UniformGroups.new(hash, 2)
#   groups.each { |group| do_something_with(group) }
class UniformGroups
  VERSION = "0.0.1"

  include Enumerable

  def initialize(hash, groups_number, options = {})
    @source = hash.dup
    @groups_number = groups_number
    @header_ratio = options[:header_ratio] ||= 0

    @grouped_keys = try_array
  end

  def try_array
    grouper = ArrayGrouper.new(weights, @groups_number, keys)
    grouper.group
    grouper.grouped_keys
  end

  def each
    @grouped_keys.each do |keys|
      yield @source.slice(*keys)
    end
  end

  private

  def weights
    @source.values.map { |v| v.length }
  end

  def keys
    @source.keys
  end

end
