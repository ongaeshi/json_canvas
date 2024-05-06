# frozen_string_literal: true

require "securerandom"

module JsonCanvas
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
end
