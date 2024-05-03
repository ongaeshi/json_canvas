# frozen_string_literal: true

require_relative "json_canvas/version"
require "json"
require "securerandom"

module JsonCanvas
  def self.create()
    Canvas.new
  end

  def self.load(json)
    Canvas.load(json)
  end

  class GenericNode
    attr_accessor :id, :x, :y, :width, :height, :color

    def initialize(**kwargs)
      @id = kwargs[:id] || SecureRandom.uuid.gsub('-', '')[0...16]
      @x = kwargs[:x] || 0
      @y = kwargs[:y] || 0
      @width = kwargs[:width] || 250
      @height = kwargs[:height] || 60 
      @color = kwargs[:color] # Optional
    end

    def to_hash_common(type)
      h = {
        "id" => id,
        "x" => x,
        "y" => y,
        "width" => width,
        "height" => height,
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

  class Canvas
    attr_reader :nodes, :edges

    def self.load(json)
    end

    def initialize(nodes = [], edges = [])
      @nodes = nodes
      @edges = edges
    end

    def add_text(**kwargs)
      node = TextNode.new(**kwargs)
      nodes.push(node)
      node
    end

    def add_file(**kwargs)
      node = FileNode.new(**kwargs)
      nodes.push(node)
      node
    end

    # def add_edge(edge)
    # end

    def to_json
      JSON.generate({
        nodes: nodes.map {|x| x.to_hash},
        edges: []
      })
    end

    # def save
    # end
  end
end
