# frozen_string_literal: true

require_relative "json_canvas/version"
require "json"
require "securerandom"

module JsonCanvas
  def self.create
    Canvas.new
  end

  def self.load(json)
    Canvas.load(json)
  end

  class GenericNode
    attr_accessor :id, :x, :y, :width, :height, :color

    def initialize(**kwargs)
      @id = kwargs[:id] || SecureRandom.uuid.delete("-")[0...16]
      @x = kwargs[:x] || 0
      @y = kwargs[:y] || 0
      @width = kwargs[:width] || default_width
      @height = kwargs[:height] || default_height
      @color = kwargs[:color] # Optional
    end

    def default_width = is_a?(TextNode) ? 250 : 400

    def default_height = is_a?(TextNode) ? 60 : 400

    def to_hash_common(type)
      h = {
        "id" => id,
        "x" => x,
        "y" => y,
        "width" => width,
        "height" => height
      }
      h["color"] = color if color
      h["type"] = type
      h
    end
  end

  class TextNode < GenericNode
    attr_accessor :type, :text

    def initialize(**kwargs)
      super(**kwargs)
      @type = "text"
      @text = kwargs[:text] || ""
    end

    def to_hash
      h = to_hash_common(type)
      h["text"] = text
      h
    end
  end

  class FileNode < GenericNode
    attr_accessor :type, :file, :subpath

    def initialize(**kwargs)
      super(**kwargs)
      @type = "file"
      @file = kwargs[:file] || ""
      @subpath = kwargs[:subpath]
    end

    def to_hash
      h = to_hash_common(type)
      h["file"] = file
      h["subpath"] = subpath if subpath
      h
    end
  end

  class LinkNode < GenericNode
    attr_accessor :type, :url

    def initialize(**kwargs)
      super(**kwargs)
      @type = "link"
      @url = kwargs[:url] || "https://www.ruby-lang.org"
    end

    def to_hash
      h = to_hash_common(type)
      h["url"] = url
      h
    end
  end

  class GroupNode < GenericNode
    attr_accessor :type, :label, :background, :background_style

    def initialize(**kwargs)
      super(**kwargs)
      @type = "group"
      @label = kwargs[:label]
      @background = kwargs[:background]
      @background_style = kwargs[:backgroundStyle]
    end

    def to_hash
      h = to_hash_common(type)
      h["label"] = label if label
      h["background"] = background if background
      h["backgroundStyle"] = background_style if background_style
      h
    end
  end

  class Edge
    attr_accessor :id, :from_node, :from_side, :from_end, :to_node, :to_side, :to_end, :color, :label

    def initialize(**kwargs)
      @id = kwargs[:id] || SecureRandom.uuid.delete("-")[0...16]
      @from_node = kwargs[:fromNode] || raise
      @from_side = kwargs[:fromSide] || "right" # "top" | "right" | "bottom" | "left"
      @from_end = kwargs[:fromEnd] # "none" | "arrow"
      @to_node = kwargs[:toNode] || raise
      @to_side = kwargs[:toSide] || "left"
      @to_end = kwargs[:toEnd]
      @color = kwargs[:color]
      @label = kwargs[:label]
    end

    def to_hash
      h = {
        "id" => id,
        "fromNode" => from_node,
        "toNode" => to_node
      }
      h["fromSide"] = from_side if from_side
      h["fromEnd"] = from_end if from_end
      h["toSide"] = to_side if to_side
      h["toEnd"] = to_end if to_end
      h["color"] = color if color
      h["label"] = label if label
      h
    end
  end

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

    # def save
    # end
  end
end
