require 'position_collision_correction'
require 'empty_position_correction'

module TreePositioning
  def self.included(base)
    base.send(:include, EmptyPositionCorrection)
    base.send(:include, PositionCollisionCorrection)
  end
end