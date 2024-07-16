require "test_helper"

class ExtractionTest < ActiveSupport::TestCase
  test "should not save extraction without a brewer" do
    extraction = Extraction.new
    assert_not extraction.save
  end
end
