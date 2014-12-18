require 'spec_helper'

describe UniformGroups::ArrayGrouper do
  {
    [4, 2, 2] => [[4], [2, 2]],
    [3, 2, 1] => [[3], [2, 1]],
    [2, 1, 3] => [[2, 1], [3]],
    [7, 8, 3] => [[7], [8], [3]],
    [7, 8, 9, 3] => [[7], [8], [9], [3]],
    [5, 5, 1] => [[5], [5, 1]]

  }.each do |source, expected_result|
    it do
      groups_number = expected_result.count
      grouper = described_class.new(source, groups_number)
      expect(grouper.group).to eq(expected_result)
    end
  end
end
