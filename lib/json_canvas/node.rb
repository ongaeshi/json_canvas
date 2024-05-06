# frozen_string_literal: true

require "securerandom"

module JsonCanvas
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
end
