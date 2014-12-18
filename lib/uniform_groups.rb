require 'active_support/core_ext/enumerable'

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
  end

  def each
    group = {}
    cur_count = index = 0

    @source.each do |key, value|
      cur_count += value.length + @header_ratio
      group.merge!(key => value)

      if cur_count >= (average_weight * (index + 1))
        yield(group)
        group = {}
        index += 1
      end
    end

    yield(group) if index < @groups_number
  end

  private

  def total_weight
    headers_addition = @source.length * @header_ratio
    @total_weight ||= @source.values.sum { |arr| arr.length } + headers_addition
  end

  def average_weight
    total_weight / @groups_number.to_f
  end
end
