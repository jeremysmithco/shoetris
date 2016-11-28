require "lib/tetris"

Shoes.app width: 400, height: 620, resizable: false do
  background gray

  def rect_builder(*attrs)
    attrs.flatten!
    rect(attrs[0], attrs[1], attrs[2], attrs[3])
  end

  render_map = Proc.new do |map|
    map.rendered = shape do
      fill map.background_color
      rect(map.left, map.top, map.width * map.unit_size, map.height * map.unit_size)
    end
  end

  @map = Tetris::Map.new(render_map)

  render_piece = Proc.new do |piece|
    piece.rendered.remove if !piece.rendered.nil?
    piece.rendered = shape do
      fill piece.color
      piece.shape.each_with_index do |row, y|
        row.each_with_index do |col, x|
          rect_builder(piece.block_attributes(x, y)) if col
        end
      end
    end
  end

  @pieces = []

  @anim = animate 1 do
    if @current_piece.nil? || @current_piece.blocked_down?
      @new_piece = Tetris::TPiece.new(@map, render_piece)
      @pieces << @new_piece
      @current_piece = @new_piece
      # @anim.stop and alert('Done!')
    else
      @current_piece.move_down
    end
  end

  keypress do |key|
    if key == :left
      @current_piece.move_left
    elsif key == :right
      @current_piece.move_right
    elsif key == :up
      @current_piece.move_up
    elsif key == :down
      @current_piece.move_down
    end
  end
end
