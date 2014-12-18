require 'spec_helper'

describe UniformGroups do
  let(:source) {
    {
      "A" => %w(Armenia Australia Austria Argentina),
      "B" => %w(Belarus Belgium),
      "C" => %w(Canada China)
    }
  }

  it "works" do
    result = UniformGroups.new(source, 2)
    expected_groups = [
      {
        "A" => %w(Armenia Australia Austria Argentina),
      },
      {
        "B" => %w(Belarus Belgium),
        "C" => %w(Canada China)
      }
    ]

    result.each_with_index do |group, index|
      expect(group).to eq(expected_groups[index])
    end

  end
end
