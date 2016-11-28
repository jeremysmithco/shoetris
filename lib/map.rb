module Tetris
  class Map
    attr_reader :grid, :background_color, :unit_size, :width, :height
    attr_accessor :rendered

    def initialize(renderer = Proc.new {})
      @renderer = renderer
      @grid = default_grid

      @renderer.call(self)
    end

    def background_color
      "#efefef"
    end

    def left
      0
    end

    def top
      0
    end

    def unit_size
      40
    end

    def width
      10
    end

    def height
      15
    end

    def update_piece(piece)
      # @grid.rows.map! { |row| cols.map! { |col|  } }
    end

    private

    def default_grid
      Array.new(height, Array.new(width, false))
    end
  end
end
