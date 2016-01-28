class HumanMove
  def pick_spot(board, spot)
    if board.available_spots.include?(spot)
      spot
    end
  end
end
