# frozen_string_literal: true

require "json"

module JsonCanvas
  class Canvas
    attr_reader :nodes, :edges

    def self.load(json)
    end

    def initialize(nodes = [], edges = [])
      @nodes = nodes
      @edges = edges
    end

    def add_text(**)
      node = TextNode.new(**)
      nodes.push(node)
      node
    end

    def add_file(**)
      node = FileNode.new(**)
      nodes.push(node)
      node
    end

    def add_link(**)
      node = LinkNode.new(**)
      nodes.push(node)
      node
    end

    def add_group(**)
      node = GroupNode.new(**)
      nodes.push(node)
      node
    end

    def add_edge(**)
      edge = Edge.new(**)
      edges.push(edge)
      edge
    end

    def to_json
      JSON.generate({
        nodes: nodes.map { |x| x.to_hash },
        edges: edges.map { |x| x.to_hash }
      })
    end

    def save(filename)
      File.write(filename, to_json)
    end
  end
end
