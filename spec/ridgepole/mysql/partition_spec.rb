require "spec_helper"

RSpec.describe Ridgepole::MySQL::Partition do
  it "has a version number" do
    expect(Ridgepole::MySQL::Partition::VERSION).not_to be nil
  end
end
