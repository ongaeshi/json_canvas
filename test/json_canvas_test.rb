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
    assert_not_nil jc
    # jc = JsonCanvas::Canvas.new()
    # jc.add_node(x: 1, y: 2, text: "Hello")
    # t = jc.add_text(text: "Hello")
    # p t
    # jc.add_file()
    # jc.add_link()
    # g = jc.add_group()
    # g.resize(t1, t2, t3) # Important
    # jc.to_s
    # jc.save("path/to/file")
  end

  test "text_node_default" do
    jc = JsonCanvas.create
    t = jc.add_text
    assert_true valid_id?(t.id)
    assert_equal t.x, 0
    assert_equal t.y, 0
    assert_equal t.width, 250
    assert_equal t.height, 60
    assert_equal t.color, nil
  end

  test "text_node_to_hash" do
    jc = JsonCanvas.create
    t = jc.add_text(id: "foo", x: 10, y: 20, text: "hi")
    assert_equal t.to_hash, {"id"=>"foo", "x"=>10, "y"=>20, "width"=>250, "height"=>60, "type"=>"text", "text"=>"hi"}
    t = jc.add_text(id: "bar", color: "1")
    assert_equal t.to_hash, {"id"=>"bar", "x"=>0, "y"=>0, "width"=>250, "height"=>60, "color"=>"1", "type"=>"text", "text"=>""}
  end

  test "to_json" do
    jc = JsonCanvas.create
    assert_equal jc.to_json, "{\"nodes\":[],\"edges\":[]}"

    jc.add_text(id: "foo")
    assert_equal jc.to_json, "{\"nodes\":[{\"id\":\"foo\",\"x\":0,\"y\":0,\"width\":250,\"height\":60,\"type\":\"text\",\"text\":\"\"}],\"edges\":[]}"
    
    jc.add_text(id: "bar", x: 10, y: 20, width: 100, height: 200, color: "2", text: "BAR")
    assert_equal jc.to_json, '{"nodes":[{"id":"foo","x":0,"y":0,"width":250,"height":60,"type":"text","text":""},{"id":"bar","x":10,"y":20,"width":100,"height":200,"color":"2","type":"text","text":"BAR"}],"edges":[]}'
  end

  def valid_id?(id) = /\A[a-z0-9]{16}\z/.match?(id)
end
