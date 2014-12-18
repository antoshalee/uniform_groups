class UniformGroups

  class ArrayGrouper
    attr_reader :grouped_keys

    def initialize(array, groups_number, keys = nil)
      @array = array
      @groups_number = groups_number
      @keys = keys
      @grouped_keys = []
    end

    def group
      result = []

      group = []
      keys_group = []

      cur_count = group_index = 0

      @array.each_with_index do |elem, ind|
        cur_count += elem
        group << elem

        keys_group << @keys[ind] if @keys

        if cur_count >= (average_weight * (group_index + 1))
          result << group
          @grouped_keys << keys_group

          group = []
          keys_group = []
          group_index += 1
        end
      end

      result
    end

    def average_weight
      total_weight / @groups_number.to_f
    end

    def total_weight
      @array.sum
    end

  end
end
