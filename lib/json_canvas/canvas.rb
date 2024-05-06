# frozen_string_literal: true

require "json"
require "json_canvas/node"
require "json_canvas/edge"

module JsonCanvas
  class Canvas
    attr_reader :nodes, :edges

    def self.load(json)
      obj = JSON.load(json)
      nodes = obj["nodes"].map do |x| 
        case x["type"]
        when "text"
          TextNode.new(**x.transform_keys(&:to_sym))
        when "file"
          FileNode.new(**x.transform_keys(&:to_sym))
        when "link"
          LinkNode.new(**x.transform_keys(&:to_sym))
        when "group"
          GroupNode.new(**x.transform_keys(&:to_sym))
        else
          raise
        end
      end
      edges = obj["edges"].map { |x| Edge.new(**x.transform_keys(&:to_sym)) }
      Canvas.new(nodes, edges)
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
