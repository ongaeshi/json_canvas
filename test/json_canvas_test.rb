# frozen_string_literal: true

require "test_helper"
require "json_canvas"
require "tmpdir"

class JsonCanvasTest < Test::Unit::TestCase
  test "VERSION" do
    assert do
      ::JsonCanvas.const_defined?(:VERSION)
    end
  end

  test "constructor" do
    jc = JsonCanvas.create
    assert_not_nil jc
  end

  def valid_id?(id) = /\A[a-z0-9]{16}\z/.match?(id)

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
    assert_equal t.to_hash, {"id" => "foo", "x" => 10, "y" => 20, "width" => 250, "height" => 60, "type" => "text", "text" => "hi"}
    t = jc.add_text(id: "bar", color: "1")
    assert_equal t.to_hash, {"id" => "bar", "x" => 0, "y" => 0, "width" => 250, "height" => 60, "color" => "1", "type" => "text", "text" => ""}
  end

  test "to_json" do
    jc = JsonCanvas.create
    assert_equal jc.to_json, "{\"nodes\":[],\"edges\":[]}"

    jc.add_text(id: "foo")
    assert_equal jc.to_json, "{\"nodes\":[{\"id\":\"foo\",\"x\":0,\"y\":0,\"width\":250,\"height\":60,\"type\":\"text\",\"text\":\"\"}],\"edges\":[]}"

    jc.add_text(id: "bar", x: 10, y: 20, width: 100, height: 200, color: "2", text: "BAR")
    assert_equal jc.to_json, '{"nodes":[{"id":"foo","x":0,"y":0,"width":250,"height":60,"type":"text","text":""},{"id":"bar","x":10,"y":20,"width":100,"height":200,"color":"2","type":"text","text":"BAR"}],"edges":[]}'
  end

  test "add_file_node" do
    jc = JsonCanvas.create

    n = jc.add_file(file: "foo/bar")
    assert_equal n.type, "file"
    assert_equal n.width, 400
    assert_equal n.height, 400
    assert_equal n.file, "foo/bar"
    assert_nil n.subpath, nil

    n = jc.add_file(file: "foo/bar.md", subpath: "#baz")
    assert_equal n.type, "file"
    assert_equal n.file, "foo/bar.md"
    assert_equal n.subpath, "#baz"
  end

  test "add_link_node" do
    jc = JsonCanvas.create

    n = jc.add_link
    assert_equal n.type, "link"
    assert_equal n.width, 400
    assert_equal n.height, 400
    assert_equal n.url, "https://www.ruby-lang.org"

    n = jc.add_link(url: "https://jsoncanvas.org/spec/1.0/")
    assert_equal n.type, "link"
    assert_equal n.url, "https://jsoncanvas.org/spec/1.0/"
  end

  test "add_group_node" do
    jc = JsonCanvas.create

    n = jc.add_group
    assert_equal n.type, "group"
    assert_equal n.width, 400
    assert_equal n.height, 400
    assert_nil n.label
    assert_nil n.background
    assert_nil n.background_style

    n = jc.add_group(label: "Test Group", background: "/path/to/image", backgroundStyle: "repeat")
    assert_equal n.type, "group"
    assert_equal n.label, "Test Group"
    assert_equal n.background, "/path/to/image"
    assert_equal n.background_style, "repeat"
  end

  test "add_group" do
    jc = JsonCanvas.create
    start = jc.add_text(id: "START", text: "start")
    goal = jc.add_text(id: "GOAL", x: 400, text: "goal")
    jc.add_edge(id: "edge1", fromNode: start.id, toNode: goal.id)
    jc.add_edge(id: "edge2", fromNode: start.id, fromSide: "top", fromEnd: "arrow", toNode: goal.id, toSide: "bottom", toEnd: "arrow", color: "2", label: "HELLO")
    assert_equal jc.to_json, '{"nodes":[{"id":"START","x":0,"y":0,"width":250,"height":60,"type":"text","text":"start"},{"id":"GOAL","x":400,"y":0,"width":250,"height":60,"type":"text","text":"goal"}],"edges":[{"id":"edge1","fromNode":"START","toNode":"GOAL","fromSide":"right","toSide":"left"},{"id":"edge2","fromNode":"START","toNode":"GOAL","fromSide":"top","fromEnd":"arrow","toSide":"bottom","toEnd":"arrow","color":"2","label":"HELLO"}]}'
  end

  test "save" do
    jc = JsonCanvas.create
    start = jc.add_text(id: "START", text: "start")
    goal = jc.add_text(id: "GOAL", x: 400, text: "goal")
    jc.add_edge(id: "edge1", fromNode: start.id, toNode: goal.id)
    jc.add_edge(id: "edge2", fromNode: start.id, fromSide: "top", fromEnd: "arrow", toNode: goal.id, toSide: "bottom", toEnd: "arrow", color: "2", label: "HELLO")

    Dir.mktmpdir do |dir|
      path = File.join(dir, "test.canvas")
      jc.save(path)
      assert_equal File.read(path), jc.to_json
    end
  end

  test "parse" do
    jc = JsonCanvas.create
    start = jc.add_text(id: "START", text: "start")
    goal = jc.add_text(id: "GOAL", x: 400, text: "goal")
    jc.add_edge(id: "edge1", fromNode: start.id, toNode: goal.id)
    jc.add_edge(id: "edge2", fromNode: start.id, fromSide: "top", fromEnd: "arrow", toNode: goal.id, toSide: "bottom", toEnd: "arrow", color: "2", label: "HELLO")

    Dir.mktmpdir do |dir|
      path = File.join(dir, "test.canvas")
      jc.save(path)
      jc2 = JsonCanvas.parse(File.read(path))
      assert_equal jc.to_json, jc2.to_json
    end
  end
end
