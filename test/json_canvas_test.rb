# frozen_string_literal: true

require "test_helper"
require "json_canvas"

class JsonCanvasTest < Test::Unit::TestCase
  test "VERSION" do
    assert do
      ::JsonCanvas.const_defined?(:VERSION)
    end
  end

  test "constructor" do
    jc = JsonCanvas.create
    # jc = JsonCanvas::Canvas.new()
    # jc.add_node(x: 1, y: 2, text: "Hello")
    t = jc.add_text(x: 10, y: 0, text: "Hello")
    p t
    # jc.add_file()
    # jc.add_link()
    # g = jc.add_group()
    # g.resize(t1, t2, t3)
  end
end
