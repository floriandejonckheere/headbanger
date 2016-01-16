require 'test_helper'

class GraphTest < ActiveSupport::TestCase
  include FactoryGirl::Syntax::Methods

  test "truth" do
    assert_kind_of Module, Graph
  end
end
