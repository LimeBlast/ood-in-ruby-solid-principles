class Monster
  attr_reader :toughness, :damage, :notice, :gold, :exp

  def initialize(attrs = {})
    @toughness = attrs.fetch(:toughness, 2)
    @damage    = attrs.fetch(:damage, 2)
    @notice    = attrs.fetch(:notice, 2)
    @gold      = attrs.fetch(:gold, 2)
    @exp       = attrs.fetch(:exp, 2)

    @dead = false
  end

  def dead?
    @dead
  end

  def kill
    @dead = true
  end
end
