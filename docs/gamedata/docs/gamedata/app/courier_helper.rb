class CourierHelper

  WIDTH = 64
  HEIGHT = 64
  COURIER_ANIMATION_SPEED = 8
  ANIMATION_CONFIG = {
    available: {
      name: 'idle',
      count: 4},
    on_mission: {
      name: 'walk',
      count: 6},
    not_available: {
      name: 'idle',
      count: 4}
  }.freeze
  def self.sprite_index(animation)
    0.frame_index count: animation[:count],
                                 hold_for: COURIER_ANIMATION_SPEED,
                                 repeat: true
  end
  def self.draw(args, courier)
    animation_config = courier.animation_config || ANIMATION_CONFIG
    animation = animation_config[courier.status]

    sprite_config = {
      x: courier.x,
      y: courier.y,
      w: WIDTH,
      h: HEIGHT,
      path: "sprites/couriers/#{courier.name.downcase}/#{animation[:name]}.png",
      source_x: (courier.sprite_w || 48) * sprite_index(animation),
      source_y: 0,
      source_w: courier.sprite_w || 48,
      source_h: courier.sprite_h || 48
    }
    if courier.status == :not_available
      sprite_config.merge!({ a: 255,
                             r: 0,
                             g: 0,
                             b: 0 })
    end
    args.outputs.sprites << sprite_config
    args.outputs.labels << {
      x: courier.x, y: courier.y + HEIGHT + 4, text: courier.name,
    }.merge(DEFAULT_LABEL_CONFIG)
  end
end