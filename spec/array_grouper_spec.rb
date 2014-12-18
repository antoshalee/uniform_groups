require 'spec_helper'

describe UniformGroups::ArrayGrouper do
  {
    [4, 2, 2] => [[4], [2, 2]],
    [3, 2, 1] => [[3], [2, 1]]
  }.each do |source, result|
    it do
      grouper = described_class.new(source, 2)
      expect(grouper.group).to eq(result)
    end
  end
end
