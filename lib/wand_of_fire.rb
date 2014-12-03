require_relative 'actionable'
class WandOfFire
  include Actionable

  def action_attributes
    @attribute = :strength
    @difficulty = :toughness
  end
end
