# frozen_string_literal: true

require "json_canvas/canvas"
require "json_canvas/edge"
require "json_canvas/node"
require "json_canvas/version"

module JsonCanvas
  def self.create
    Canvas.new
  end

  def self.parse(json)
    Canvas.parse(json)
  end
end
