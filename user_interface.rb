class UserInterface

  def initialize(spot)
    @spot = spot
    @spot_taken = nil
  end

  def get_spot
   if @spot_taken == nil
      @spot_taken = @spot
      @spot
   elsif @spot_taken == @spot
     "break loop"
   end
  end

  def error
  end
end
